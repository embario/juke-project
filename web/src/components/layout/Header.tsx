import { Link, useNavigate } from 'react-router-dom';
import Button from '../shared/Button';
import useAuth from '../../hooks/useAuth';

const Header = () => {
  const { isAuthenticated, username, logout } = useAuth();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  return (
    <header className="app-header">
      <div>
        <p className="eyebrow">Curated by Juke</p>
        <h1>Music Intelligence Console</h1>
      </div>
      <div className="header__actions">
        {isAuthenticated ? (
          <>
            <span className="pill">Signed in as {username}</span>
            <Button variant="ghost" onClick={handleLogout} aria-label="Sign out">
              Sign out
            </Button>
          </>
        ) : (
          <>
            <Link to="/login" className="pill">
              Sign in
            </Link>
            <Link to="/register" className="pill pill--accent">
              Create account
            </Link>
          </>
        )}
      </div>
    </header>
  );
};

export default Header;
