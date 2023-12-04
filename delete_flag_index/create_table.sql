CREATE TABLE
    IF NOT EXISTS users (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
        name VARCHAR NOT NULL,
        email VARCHAR UNIQUE NOT NULL,
        password VARCHAR NOT NULL,
        -- 削除フラグをboolean型で表現する場合
        deleted BOOLEAN NOT NULL DEFAULT false,
        -- 削除フラグをtimestamp型で表現する場合
        -- deleted_at timestamp,
        created_at timestamp NOT NULL DEFAULT now (),
        updated_at timestamp NOT NULL DEFAULT now ()
    );