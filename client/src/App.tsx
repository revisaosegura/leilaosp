import { Toaster } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import NotFound from "@/pages/NotFound";
import { Route, Switch } from "wouter";
import ErrorBoundary from "./components/ErrorBoundary";
import { ThemeProvider } from "./contexts/ThemeContext";
import Header from "./components/Header";
import Footer from "./components/Footer";
import WhatsAppButton from "./components/WhatsAppButton";
import Home from "./pages/Home";
import HowItWorks from "./pages/HowItWorks";
import FindVehicle from "./pages/FindVehicle";
import VehicleDetail from "./pages/VehicleDetail";
import { AuctionsPage, LocationsPage, SupportPage, SellMyCarPage, DirectSalePage, FindPartsPage } from "./pages/SimplePage";
import Admin from "./pages/Admin";
import UserDashboard from "./pages/UserDashboard";

function Router() {
  return (
    <Switch>
      <Route path={"/"} component={Home} />
      <Route path={"/how-it-works"} component={HowItWorks} />
      <Route path={"/find-vehicle"} component={FindVehicle} />
      <Route path={"/vehicle/:id"} component={VehicleDetail} />
      <Route path={"/auctions"} component={AuctionsPage} />
      <Route path={"/locations"} component={LocationsPage} />
      <Route path={"/support"} component={SupportPage} />
      <Route path={"/sell-my-car"} component={SellMyCarPage} />
      <Route path={"/direct-sale"} component={DirectSalePage} />
      <Route path={"/find-parts"} component={FindPartsPage} />
      <Route path={"/admin"} component={Admin} />
      <Route path={"/dashboard"} component={UserDashboard} />
      <Route path={"/404"} component={NotFound} />
      {/* Final fallback route */}
      <Route component={NotFound} />
    </Switch>
  );
}

function App() {
  return (
    <ErrorBoundary>
      <ThemeProvider defaultTheme="light">
        <TooltipProvider>
          <Toaster />
          <Header />
          <Router />
          <Footer />
          <WhatsAppButton />
        </TooltipProvider>
      </ThemeProvider>
    </ErrorBoundary>
  );
}

export default App;
