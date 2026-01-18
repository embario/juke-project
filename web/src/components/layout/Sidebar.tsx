import { NavLink } from 'react-router-dom';

const Sidebar = () => (
  <aside className="sidebar">
    <div className="sidebar__brand">
      <span className="sidebar__burst" />
      <strong>Juke</strong>
    </div>
    <nav className="sidebar__nav">
      <NavLink to="/" end className={({ isActive }) => (isActive ? 'sidebar__link sidebar__link--active' : 'sidebar__link')}>
        Library
      </NavLink>
      <NavLink to="/login" className={({ isActive }) => (isActive ? 'sidebar__link sidebar__link--active' : 'sidebar__link')}>
        Sign in
      </NavLink>
      <NavLink
        to="/register"
        className={({ isActive }) => (isActive ? 'sidebar__link sidebar__link--active' : 'sidebar__link')}
      >
        Register
      </NavLink>
    </nav>
    <p className="sidebar__footnote">Frontend build {new Date().getFullYear()}</p>
  </aside>
);

export default Sidebar;
