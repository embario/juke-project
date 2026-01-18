import { render, screen } from '@testing-library/react';
import ArtistCard from '../components/catalog/ArtistCard';
import type { Artist } from '../types/catalog';

describe('ArtistCard', () => {
  const baseArtist: Artist = {
    id: 1,
    name: 'Tool',
    spotify_id: 'spotify:artist:tool',
  };

  it('renders fallback text when genres are missing', () => {
    render(<ArtistCard artist={baseArtist} />);

    expect(screen.getByText('Genres unavailable')).toBeInTheDocument();
  });

  it('lists genres when they are provided', () => {
    const artistWithGenres: Artist = {
      ...baseArtist,
      genres: ['prog metal', 'art rock'],
    };

    render(<ArtistCard artist={artistWithGenres} />);

    expect(screen.getByText('prog metal, art rock')).toBeInTheDocument();
  });
});
