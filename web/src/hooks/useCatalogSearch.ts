import { useCallback, useReducer } from 'react';
import { CatalogResults } from '../types/catalog';
import { fetchAllResources } from '../services/catalogService';

const initialResults: CatalogResults = {
  genres: [],
  artists: [],
  albums: [],
  tracks: [],
};

type State = {
  query: string;
  data: CatalogResults;
  isLoading: boolean;
  error: string | null;
};

const initialState: State = {
  query: '',
  data: initialResults,
  isLoading: false,
  error: null,
};

type Action =
  | { type: 'request'; query: string }
  | { type: 'success'; payload: CatalogResults }
  | { type: 'failure'; message: string };

const reducer = (state: State, action: Action): State => {
  switch (action.type) {
    case 'request':
      return { ...state, query: action.query, isLoading: true, error: null };
    case 'success':
      return { ...state, data: action.payload, isLoading: false };
    case 'failure':
      return { ...state, isLoading: false, error: action.message };
    default:
      return state;
  }
};

export const useCatalogSearch = (token: string | null) => {
  const [state, dispatch] = useReducer(reducer, initialState);

  const runSearch = useCallback(
    async (query: string) => {
      if (!token) {
        dispatch({ type: 'failure', message: 'Authenticate to browse the catalog.' });
        return;
      }
      dispatch({ type: 'request', query });
      try {
        const payload = await fetchAllResources(token, query.trim());
        dispatch({ type: 'success', payload });
      } catch (error) {
        dispatch({
          type: 'failure',
          message: error instanceof Error ? error.message : 'Unable to fetch catalog.',
        });
      }
    },
    [token],
  );

  return {
    query: state.query,
    data: state.data,
    isLoading: state.isLoading,
    error: state.error,
    runSearch,
  };
};

export default useCatalogSearch;
