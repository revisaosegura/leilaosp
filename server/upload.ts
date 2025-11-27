// pages/api/upload-b2.ts
import { NextApiRequest, NextApiResponse } from 'next';
import AWS from 'aws-sdk';
import multer from 'multer';
import { NextRequest } from 'next/server';

// Configuração do AWS S3 para Backblaze B2
const s3 = new AWS.S3({
  endpoint: process.env.B2_ENDPOINT,
  region: process.env.B2_ENDPOINT?.includes('us-west-002') ? 'us-west-002' : 'us-west-001',
  credentials: {
    accessKeyId: process.env.B2_ACCESS_KEY_ID!,
    secretAccessKey: process.env.B2_SECRET_ACCESS_KEY!,
  },
  signatureVersion: 'v4',
});

// Configuração do Multer - VERSÃO CORRIGIDA
const upload = multer({
  storage: multer.memoryStorage(),
  limits: {
    fileSize: 10 * 1024 * 1024, // 10MB
    files: 10, // máximo 10 arquivos
  },
  fileFilter: (req, file, cb) => {
    // Aceitar apenas imagens
    if (file.mimetype.startsWith('image/')) {
      cb(null, true);
    } else {
      cb(new Error('Apenas imagens são permitidas'));
    }
  },
});

// EXTENDER o tipo NextApiRequest para incluir files
interface NextApiRequestWithFiles extends NextApiRequest {
  files?: Express.Multer.File[];
}

// Helper para usar multer com Next.js - VERSÃO CORRIGIDA
const runMiddleware = (req: NextApiRequest, res: NextApiResponse, fn: any) => {
  return new Promise((resolve, reject) => {
    // Multer precisa do res para anexar os files
    fn(req, res, (result: any) => {
      if (result instanceof Error) {
        return reject(result);
      }
      return resolve(result);
    });
  });
};

export const config = {
  api: {
    bodyParser: false, // IMPORTANTE: Desativar bodyParser
  },
};

export default async function handler(
  req: NextApiRequestWithFiles,
  res: NextApiResponse
) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Método não permitido' });
  }

  console.log('🔧 Iniciando upload B2...');

  try {
    // PASSO 1: Processar o upload com Multer
    console.log('📤 Processando arquivos com Multer...');
    await runMiddleware(req, res, upload.array('images', 10));
    
    // PASSO 2: Verificar se os arquivos foram processados
    const files = req.files;
    console.log('📁 Arquivos recebidos:', files?.length || 0);

    if (!files || files.length === 0) {
      console.log('❌ Nenhum arquivo processado pelo Multer');
      return res.status(400).json({ error: 'Nenhuma imagem enviada ou formato inválido' });
    }

    // PASSO 3: Fazer upload para Backblaze B2
    console.log('☁️ Enviando para Backblaze B2...');
    const uploadPromises = files.map(async (file, index) => {
      try {
        const fileExtension = file.originalname.split('.').pop() || 'jpg';
        const key = `vehicles/${Date.now()}-${index}-${Math.random()
          .toString(36)
          .substring(7)}.${fileExtension}`;

        const params = {
          Bucket: process.env.B2_BUCKET_NAME!,
          Key: key,
          Body: file.buffer,
          ContentType: file.mimetype,
          ACL: 'public-read' as const,
        };

        console.log(`📤 Uploading ${index + 1}/${files.length}: ${key}`);
        const result = await s3.upload(params).promise();
        console.log(`✅ Upload success: ${result.Location}`);
        
        return result.Location;
      } catch (fileError) {
        console.error(`❌ Erro no arquivo ${index}:`, fileError);
        throw fileError;
      }
    });

    const imageUrls = await Promise.all(uploadPromises);
    
    console.log('🎉 Upload concluído! URLs:', imageUrls);

    res.json({
      success: true,
      imageUrls,
      message: `${imageUrls.length} imagem(ns) uploadada(s) com sucesso`,
    });

  } catch (error: any) {
    console.error('❌ ERRO NO UPLOAD B2:', error);
    
    // Erros específicos
    if (error.code === 'InvalidAccessKeyId') {
      return res.status(500).json({ 
        error: 'Access Key ID inválido. Verifique B2_ACCESS_KEY_ID no Render.' 
      });
    }
    
    if (error.message?.includes('multipart')) {
      return res.status(400).json({ 
        error: 'Erro no formato do upload. Certifique-se de enviar como multipart/form-data' 
      });
    }

    res.status(500).json({ 
      error: `Erro no upload: ${error.message || 'Erro desconhecido'}` 
    });
  }
}
