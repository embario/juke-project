type RequestOptions = RequestInit & {
  token?: string | null;
  query?: Record<string, string | number | undefined>;
};

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL ?? 'http://localhost:8000';

const buildUrl = (path: string, query?: Record<string, string | number | undefined>) => {
  const url = new URL(path, API_BASE_URL);
  if (query) {
    Object.entries(query).forEach(([key, value]) => {
      if (value !== undefined && value !== '') {
        url.searchParams.set(key, String(value));
      }
    });
  }
  return url.toString();
};

async function request<T>(path: string, options: RequestOptions = {}): Promise<T> {
  const { token, query, headers, ...rest } = options;
  const url = buildUrl(path, query);
  const response = await fetch(url, {
    ...rest,
    headers: {
      'Content-Type': 'application/json',
      ...(token ? { Authorization: `Token ${token}` } : {}),
      ...headers,
    },
  });

  if (!response.ok) {
    const detail = await safeParse(response);
    const message = detail?.detail ?? response.statusText;
    throw new Error(message);
  }

  if (response.status === 204) {
    return {} as T;
  }

  return response.json() as Promise<T>;
}

async function safeParse(response: Response) {
  try {
    return await response.json();
  } catch (error) {
    return undefined;
  }
}

export const apiClient = {
  get: <T>(path: string, options?: RequestOptions) => request<T>(path, { method: 'GET', ...options }),
  post: <T>(path: string, body?: unknown, options?: RequestOptions) =>
    request<T>(path, {
      method: 'POST',
      body: body ? JSON.stringify(body) : undefined,
      ...options,
    }),
};

export default apiClient;
