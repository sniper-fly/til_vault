---
tags:
  - 個人開発
---

```mermaid
erDiagram
    ANIME {
        number anilist_id PK
        number myanimelist_id
        string anime_title
    }
    SONGS {
        boolean searched_as_song
        string title
        string jp_title
        string slug
        string[] artists
        string newTable_anilist_id FK
    }
    STREAMING {
        string provider
        string uri PK
        string name
        string[] artists
        string open_link
        string preview_url
        string image
        number duration_ms
        string[] available_markets
        number added_count
        number vote_as_official
        string songs_title FK
    }
    ANIME ||--o{ SONGS : "has"
    SONGS ||--o{ STREAMING : "has"

```