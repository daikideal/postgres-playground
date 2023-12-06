-- deleted に単体インデックス
CREATE INDEX IF NOT EXISTS users_deleted_index ON users (deleted);

-- name に単体インデックス
CREATE INDEX IF NOT EXISTS users_name_index ON users (name);

-- name と deleted の複合インデックス
CREATE INDEX IF NOT EXISTS users_name_deleted_index ON users (name, deleted);

-- deleted と name の順序を入れ替えた複合インデックス
CREATE INDEX IF NOT EXISTS users_deleted_name_index ON users (deleted, name);