declare global {
  const __DISABLE_REGISTRATION_EMAILS__: string;
  interface Window {
    ENV?: {
      VITE_API_BASE_URL?: string;
      BACKEND_URL?: string;
      [key: string]: string | undefined;
    };
  }
}

export {};
