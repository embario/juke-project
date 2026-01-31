import { useState, useCallback, useRef } from 'react';
import { GlobePoint } from '../types';
import { fetchGlobePoints, GlobeQueryParams } from '../api/worldApi';

type UseGlobePointsReturn = {
  points: GlobePoint[];
  loading: boolean;
  error: string | null;
  loadPoints: (params: GlobeQueryParams) => void;
};

export function useGlobePoints(token: string | null): UseGlobePointsReturn {
  const [points, setPoints] = useState<GlobePoint[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const abortRef = useRef<AbortController | null>(null);
  const cacheRef = useRef<Map<string, GlobePoint[]>>(new Map());
  const lastKeyRef = useRef<string | null>(null);
  const pointMapRef = useRef<Map<number, GlobePoint>>(new Map());

  const loadPoints = useCallback(
    (params: GlobeQueryParams) => {
      const latCenter = (params.min_lat + params.max_lat) / 2;
      const lngCenter = (params.min_lng + params.max_lng) / 2;
      const latBucket = Math.round(latCenter / 25);
      const lngBucket = Math.round(lngCenter / 25);
      const zoomBucket = Math.round(params.zoom / 2);
      const limitBucket = params.limit ?? 5000;
      const key = `${latBucket}:${lngBucket}:${zoomBucket}:${limitBucket}`;

      const hydratePoints = (data: GlobePoint[]) => {
        const merged: GlobePoint[] = [];
        data.forEach((point) => {
          const existing = pointMapRef.current.get(point.id);
          if (
            existing &&
            existing.lat === point.lat &&
            existing.lng === point.lng &&
            existing.clout === point.clout &&
            existing.top_genre === point.top_genre &&
            existing.display_name === point.display_name
          ) {
            merged.push(existing);
          } else {
            pointMapRef.current.set(point.id, point);
            merged.push(point);
          }
        });
        return merged;
      };

      if (key === lastKeyRef.current && cacheRef.current.has(key)) {
        setPoints(hydratePoints(cacheRef.current.get(key) ?? []));
        setLoading(false);
        return;
      }

      const cached = cacheRef.current.get(key);
      if (cached) {
        lastKeyRef.current = key;
        setPoints(hydratePoints(cached));
        setLoading(false);
        return;
      }

      // Cancel previous in-flight request
      if (abortRef.current) {
        abortRef.current.abort();
      }
      const controller = new AbortController();
      abortRef.current = controller;

      setLoading(true);
      setError(null);

      fetchGlobePoints(params, token)
        .then((data) => {
          if (!controller.signal.aborted) {
            cacheRef.current.set(key, data);
            lastKeyRef.current = key;
            setPoints(hydratePoints(data));
            setLoading(false);
          }
        })
        .catch((err) => {
          if (!controller.signal.aborted) {
            setError(err.message || 'Failed to load globe points');
            setLoading(false);
          }
        });
    },
    [token],
  );

  return { points, loading, error, loadPoints };
}
