import { Artist } from '../../types/catalog';

const ArtistCard = ({ artist }: { artist: Artist }) => {
  const genreLabels = Array.isArray(artist.genres)
    ? artist.genres.map((genre) => (typeof genre === 'string' ? genre : genre.name))
    : [];

  const subtitle = genreLabels.length ? genreLabels.join(', ') : 'Genres unavailable';

  return (
    <article className="card card--compact">
      <h4>{artist.name}</h4>
      <p className="muted">{subtitle}</p>
    </article>
  );
};

export default ArtistCard;
