-- deleted に単体インデックス
CREATE INDEX IF NOT EXISTS users_deleted_index ON users (deleted);

-- email と deleted の複合インデックス
CREATE INDEX IF NOT EXISTS users_email_deleted_index ON users (email, deleted);

-- deleted と email の順序を入れ替えた複合インデックス
CREATE INDEX IF NOT EXISTS users_deleted_email_index ON users (deleted, email);