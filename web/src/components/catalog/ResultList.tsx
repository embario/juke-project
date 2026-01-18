import { Album, Artist, Track } from '../../types/catalog';
import AlbumCard from './AlbumCard';
import ArtistCard from './ArtistCard';
import TrackCard from './TrackCard';

type Props = {
  title: string;
  items: Album[] | Artist[] | Track[];
  variant: 'album' | 'artist' | 'track';
  emptyCopy: string;
};

const ResultList = ({ title, items, variant, emptyCopy }: Props) => (
  <div className="result-list">
    <div className="result-list__header">
      <p className="eyebrow">{variant}</p>
      <h3>{title}</h3>
    </div>
    {items.length === 0 ? <p className="muted">{emptyCopy}</p> : null}
    <ul>
      {items.map((item) => {
        const key = (item as Album | Artist | Track).spotify_id ?? (item as Album | Artist | Track).id;
        if (variant === 'album') {
          return (
            <li key={key}>
              <AlbumCard album={item as Album} />
            </li>
          );
        }
        if (variant === 'artist') {
          return (
            <li key={key}>
              <ArtistCard artist={item as Artist} />
            </li>
          );
        }
        return (
          <li key={key}>
            <TrackCard track={item as Track} />
          </li>
        );
      })}
    </ul>
  </div>
);

export default ResultList;
