# ERD: Tickitz

```mermaid

erDiagram
    direction LR

    users ||--o{ sessions :"creates"
    users ||--|| profile :has
    users ||--o{ transactions:makes
    transactions ||--o{ transactions_detail:contains
    transactions_detail }o--||movies:has
    movie_genres||--|{ genres:has
    movies }|--|| movie_genres:has
    movie_casts||--|{ casts:has
    movies }|--|| movie_casts:has
    movies }|--|| movie_directors : has
    movie_directors||--|{ directors:has
    payments||--|{transactions_detail:"needed by"

    users {
        int       id            PK
        string    email         UK
        string    username      UK
        string    password
        string    role
        datetime  created_at
    }

    sessions {
        int       id            PK
        int       user_id       FK
        string    token
        string    device_info
        boolean   is_active
        datetime  created_at
        datetime  expired_at
    }

    profile {
        int       id            PK
        int       user_id       FK
        string    firstname 
        string    lastname 
    }

    movies {
        int         id              PK
        string      title
        string      synopsis
        time        duration
        date        release_date
        string      rating
        string      backdrop_img
        string      poster_img
        decimal     price
        datetime    created_at
    }

    movie_casts{
        int    id           PK
        int    movies_id    FK
        int    casts_id     FK
    }
    casts {
        int     id    PK
        string  name
        string  role
    }

    movie_directors{
        int    id   PK
        int    movies_id       FK
        int    directors_id    FK
    }
    directors {
        int     id    PK
        string  name  
    }

    movie_genres{
        int    id           PK
        int    movies_id    FK
        int    genres_id    FK
    }
    genres {
        int     id    PK
        string  name
    }

    payments{
        int     id    PK
        string  name
    }

    transactions{
        int         id           PK
        boolean     status
        datetime    created_at
    }
    transactions_detail {
        int     id               PK
        int     transactions_id  FK
        int     user_id          FK
        int     movie_id         FK
        int     payment_id       FK
        int     seats
    }

```

<!--
1. Register
   - id langsung digenerate
   - ketika user register data email, username dan password disimpen di tabel users
   - email, username , dan password harus UNIQUE
   - password harus di hash dulu sebelum masuk
   - role default (user) langsung diberikan
   - is_active masih false
   - created_at ditrigger
2. Login
   - mencocokan input email dan password di tabel users.
   - cocok? atribut is_active ubah ke true
   - token di generate
   - created_at & expired_at di generate
   - device info digenerate
   - user_id ngambil dari atribut id ditabel users
3. Logout
   - is_active diubah jadi false
4. Reset Password
   - user request reset_token
   - created_at dan expired_at digenerate
   - user udah pake token, is_used ubah ke true
 -->
