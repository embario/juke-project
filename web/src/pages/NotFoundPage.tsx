import { Link } from 'react-router-dom';

const NotFoundPage = () => (
  <section className="not-found">
    <h2>Route not charted</h2>
    <p className="muted">The requested interface does not exist yet.</p>
    <Link to="/">Return home</Link>
  </section>
);

export default NotFoundPage;
