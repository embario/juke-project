import { Track } from '../../types/catalog';
import { formatDuration } from '../../utils/formatters';

const TrackCard = ({ track }: { track: Track }) => (
  <article className="card card--compact track-card">
    <div>
      <h4>{track.name}</h4>
      <p className="muted">Track {track.track_number}</p>
    </div>
    <span>{formatDuration(track.duration_ms)}</span>
  </article>
);

export default TrackCard;
