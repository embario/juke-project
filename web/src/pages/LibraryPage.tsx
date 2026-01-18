import { useState } from 'react';
import { Link } from 'react-router-dom';
import SearchBar from '../components/catalog/SearchBar';
import ResultsPanel from '../components/catalog/ResultsPanel';
import useAuth from '../hooks/useAuth';
import useCatalogSearch from '../hooks/useCatalogSearch';
import { CatalogFilter } from '../types/catalog';

const DEFAULT_FILTERS: CatalogFilter[] = ['albums', 'artists', 'tracks'];

const LibraryPage = () => {
  const { token, isAuthenticated } = useAuth();
  const [filters, setFilters] = useState<CatalogFilter[]>(DEFAULT_FILTERS);
  const [fieldValue, setFieldValue] = useState('');
  const { data, runSearch, isLoading, error } = useCatalogSearch(token);

  const toggleFilter = (filter: CatalogFilter) => {
    setFilters((prev) => {
      if (prev.includes(filter)) {
        if (prev.length === 1) {
          return prev;
        }
        return prev.filter((entry) => entry !== filter);
      }
      return [...prev, filter];
    });
  };

  const handleSubmit = (value: string) => {
    runSearch(value);
  };

  return (
    <section className="library">
      <div className="library__hero">
        <p className="eyebrow">Exploration</p>
        <h2>Interrogate the catalog in real time</h2>
        <p className="muted">Query albums, artists, and tracks pulled from the Django API.</p>
        {!isAuthenticated ? (
          <p className="warning">
            Authentication required. <Link to="/login">Sign in</Link> or <Link to="/register">create an account</Link>.
          </p>
        ) : null}
      </div>
      <SearchBar
        value={fieldValue}
        onChange={setFieldValue}
        onSubmit={handleSubmit}
        filters={filters}
        onToggleFilter={toggleFilter}
      />
      <ResultsPanel data={data} filters={filters} isLoading={isLoading} error={error} />
    </section>
  );
};

export default LibraryPage;
