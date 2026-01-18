type Props = {
  message: string | null;
};

const ErrorBanner = ({ message }: Props) => {
  if (!message) {
    return null;
  }
  return <div className="error-banner">{message}</div>;
};

export default ErrorBanner;
