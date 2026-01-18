export type Genre = {
  id: number;
  name: string;
  spotify_id: string;
};

export type Artist = {
  id: number;
  name: string;
  genres?: Array<string | Genre>;
  spotify_id: string;
};

export type Album = {
  id: number;
  name: string;
  artists?: Array<Artist | string | number>;
  total_tracks: number;
  release_date: string;
  spotify_id: string;
};

export type Track = {
  id: number;
  name: string;
  album: Album | number | string;
  duration_ms: number;
  track_number: number;
  explicit: boolean;
  spotify_id: string;
};

export type CatalogResults = {
  genres: Genre[];
  artists: Artist[];
  albums: Album[];
  tracks: Track[];
};

export type CatalogFilter = 'albums' | 'artists' | 'tracks';
