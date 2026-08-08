# Recyclarr

This deployment uses Recyclarr v8 guide-backed quality profiles. Recyclarr
automatically synchronizes their qualities, mandatory custom formats, scores,
and upgrade cutoffs from the TRaSH Guides. The explicit custom-format groups add
the official quick-setup choices and a few deliberate home-theatre preferences.

## Which profile to use

Recyclarr creates and maintains profiles; it does not decide which profile a
movie or series should use. Pick these in Radarr/Sonarr (or configure the same
defaults in an upstream request application):

| App | Profile | Use it for |
| --- | --- | --- |
| Radarr | `UHD Bluray + WEB` | Most movies; 4K/HDR without remux-sized files |
| Radarr | `Remux + WEB 2160p` | Favourite and showcase movies on the 77-inch OLED |
| Radarr | `HD Bluray + WEB` | Movies unavailable in 4K or not worth UHD storage |
| Sonarr | `WEB-1080p` | Most and long-running TV series |
| Sonarr | `WEB-2160p` | Prestige/nature/science-fiction series worth keeping in 4K |
| Both | `Remux-1080p - Anime` | Anime only |

The OLED policy boosts Dolby Vision when the release also has HDR fallback,
rejects Dolby Vision without fallback for wider client compatibility, and
rejects SDR UHD disc sources while retaining SDR WEB-DL as a last resort. It
does not boost HDR10+ because display support varies. Radarr also prefers
Hybrid, IMAX, and IMAX Enhanced releases when available.

Media naming follows Jellyfin's TMDB/TVDB conventions. Renaming is enabled for
new imports, but changing these settings does not bulk-rename the existing
library. Use Radarr/Sonarr's previewable Organize/Rename action if desired.

The existing profile names are intentionally pinned during the v7-to-v8
migration. This lets the first v8 sync adopt those profiles instead of creating
duplicates. The anime names may be removed after a successful sync if the
guide-standard `[Anime] Remux-1080p` name is preferred.

Radarr and Sonarr each expose only one global quality definition. Their standard
movie/series definitions are retained because the same instances also host the
anime profiles. Separate service instances are required to use the anime quality
definitions independently.

`Propers and Repacks` is set to `Do Not Prefer`; the guide-backed custom formats
handle those upgrades with more precision.

The `/config` PVC persists Recyclarr's sync state. Downloaded guide data and logs
are mounted at `/data` and remain ephemeral.

- [Recyclarr documentation](https://recyclarr.dev/)
- [v8 upgrade guide](https://recyclarr.dev/guide/upgrade-guide/v8.0/)
- [Quick setup templates](https://recyclarr.dev/guide/guide-configs/)
- [Recyclarr source](https://github.com/recyclarr/recyclarr)
