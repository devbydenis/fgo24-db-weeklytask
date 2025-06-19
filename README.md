-- Active: 1750218772421@@127.0.0.1@5432@postgres

# ERD: Tickitz

```mermaid

erDiagram
    direction LR

    users ||--|{ sessions :create
    movie_genres||--|{ genres:has
    transactions ||--|{ transactions_detail:has
    transactions_detail }o--||movies:has
    movies }|--|| movie_genres:has
    movie_casts||--|{ casts:has
    movies }|--|| movie_casts:has
    movies }|--|| movie_directors : has
    movie_directors||--|{ directors:has
    users ||--|{ transactions_detail:do
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

    movies {
        int         id              PK
        int         genres_id       FK
        int         cast_id         FK
        int         director_id     FK
        string      title
        string      synopsis
        string      duration
        string      release_date
        string      rating
        string      backdrop_img
        string      poster_img
        int         price
        datetime    created_at
    }

    movie_casts{
        int    id   PK
        int    id_movies    FK
        int    id_casts    FK
    }

    movie_directors{
        int    id   PK
        int    id_movies    FK
        int    id_directors    FK
    }


    genres {
        int     id    PK
        string  name
    }
    movie_genres{
        int    id   PK
        int    movies_id    FK
        int    genres_id    FK
    }

    casts {
        int     id    PK
        string  name
        string  role
    }


    directors {
        int     id    PK
        string  name  
    }

    payments{
        int     id    PK
        string  name
    }

    transactions{
        int         id          PK
        boolean     status
        datetime    created_at
    }

    transactions_detail {
        int     id               PK
        int     transactions_id  FK
        int     user_id          FK
        int     movies_id        FK
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
