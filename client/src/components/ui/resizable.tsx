import * as React from "react";
import { GripVerticalIcon } from "lucide-react";
import * as ResizablePrimitive from "react-resizable-panels";

import { cn } from "@/lib/utils";
import { useIsMobile } from "@/hooks/useMobile";

type ResizableContextValue = {
  isMobile: boolean;
  direction: "horizontal" | "vertical";
};

const ResizableContext = React.createContext<ResizableContextValue>({
  isMobile: false,
  direction: "horizontal",
});

function ResizablePanelGroup({
  className,
  children,
  direction = "horizontal",
  ...props
}: React.ComponentProps<typeof ResizablePrimitive.PanelGroup>) {
  const isMobile = useIsMobile();
  const activeDirection: ResizableContextValue["direction"] = isMobile
    ? "vertical"
    : direction;

  if (isMobile) {
    return (
      <ResizableContext.Provider value={{ isMobile: true, direction: activeDirection }}>
        <div
          data-slot="resizable-panel-group"
          data-panel-group-direction={activeDirection}
          className={cn("flex h-full w-full flex-col gap-2", className)}
        >
          {children}
        </div>
      </ResizableContext.Provider>
    );
  }

  return (
    <ResizableContext.Provider value={{ isMobile: false, direction: activeDirection }}>
      <ResizablePrimitive.PanelGroup
        data-slot="resizable-panel-group"
        className={cn(
          "flex h-full w-full data-[panel-group-direction=vertical]:flex-col",
          className
        )}
        direction={direction}
        {...props}
      >
        {children}
      </ResizablePrimitive.PanelGroup>
    </ResizableContext.Provider>
  );
}

function ResizablePanel({
  className,
  children,
  defaultSize: _defaultSize,
  minSize: _minSize,
  maxSize: _maxSize,
  order: _order,
  collapsible: _collapsible,
  collapsedSize: _collapsedSize,
  onCollapse: _onCollapse,
  onExpand: _onExpand,
  onResize: _onResize,
  ...props
}: React.ComponentProps<typeof ResizablePrimitive.Panel>) {
  const { isMobile } = React.useContext(ResizableContext);

  if (isMobile) {
    return (
      <div
        data-slot="resizable-panel"
        className={cn("min-h-[120px] w-full", className)}
        {...(props as React.HTMLAttributes<HTMLDivElement>)}
      >
        {children}
      </div>
    );
  }

  return (
    <ResizablePrimitive.Panel
      data-slot="resizable-panel"
      className={className}
      defaultSize={_defaultSize}
      minSize={_minSize}
      maxSize={_maxSize}
      order={_order}
      collapsible={_collapsible}
      collapsedSize={_collapsedSize}
      onCollapse={_onCollapse}
      onExpand={_onExpand}
      onResize={_onResize}
      {...props}
    >
      {children}
    </ResizablePrimitive.Panel>
  );
}

function ResizableHandle({
  withHandle,
  className,
  ...props
}: React.ComponentProps<typeof ResizablePrimitive.PanelResizeHandle> & {
  withHandle?: boolean;
}) {
  const { isMobile, direction } = React.useContext(ResizableContext);

  if (isMobile) {
    return (
      <div
        data-slot="resizable-handle"
        data-panel-group-direction={direction}
        className={cn(
          "bg-border relative flex h-px w-full items-center justify-center",
          className
        )}
      >
        {withHandle && (
          <div className="bg-border z-10 flex h-4 w-3 items-center justify-center rounded-xs border">
            <GripVerticalIcon className="size-2.5" />
          </div>
        )}
      </div>
    );
  }

  return (
    <ResizablePrimitive.PanelResizeHandle
      data-slot="resizable-handle"
      className={cn(
        "bg-border focus-visible:ring-ring relative flex w-px items-center justify-center after:absolute after:inset-y-0 after:left-1/2 after:w-1 after:-translate-x-1/2 focus-visible:ring-1 focus-visible:ring-offset-1 focus-visible:outline-hidden data-[panel-group-direction=vertical]:h-px data-[panel-group-direction=vertical]:w-full data-[panel-group-direction=vertical]:after:left-0 data-[panel-group-direction=vertical]:after:h-1 data-[panel-group-direction=vertical]:after:w-full data-[panel-group-direction=vertical]:after:translate-x-0 data-[panel-group-direction=vertical]:after:-translate-y-1/2 [&[data-panel-group-direction=vertical]>div]:rotate-90",
        className
      )}
      {...props}
    >
      {withHandle && (
        <div className="bg-border z-10 flex h-4 w-3 items-center justify-center rounded-xs border">
          <GripVerticalIcon className="size-2.5" />
        </div>
      )}
    </ResizablePrimitive.PanelResizeHandle>
  );
}

export { ResizablePanelGroup, ResizablePanel, ResizableHandle };
