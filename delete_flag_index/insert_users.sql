-- 10,000,000件のレコードをusersテーブルに挿入する。
-- 1/10が論理削除済みのレコードとする。

-- ランダムなユーザー名を生成
CREATE OR REPLACE FUNCTION generate_random_name()
RETURNS TEXT AS $$
DECLARE
    -- 英語圏のファーストネーム * 100
    first_names TEXT[] := ARRAY['James', 'Emma', 'William', 'Olivia', 'Alexander', 'Sophia', 'Michael', 'Isabella', 'Daniel', 'Ava', 'Matthew', 'Mia', 'Christopher', 'Amelia', 'Andrew', 'Harper', 'Ethan', 'Evelyn', 'Benjamin', 'Abigail', 'Nicholas', 'Emily', 'Joseph', 'Charlotte', 'Samuel', 'Scarlett', 'Benjamin', 'Grace', 'Jackson', 'Lily', 'David', 'Hannah', 'Oliver', 'Chloe', 'Henry', 'Aria', 'Sebastian', 'Ellie', 'Jack', 'Madison', 'Aiden', 'Scarlett', 'Gabriel', 'Zoe', 'Logan', 'Penelope', 'Caleb', 'Riley', 'Lucas', 'Layla', 'John', 'Aurora', 'Luke', 'Addison', 'Anthony', 'Hazel', 'Isaac', 'Violet', 'Daniel', 'Stella', 'Julian', 'Aurora', 'Matthew', 'Lucy', 'Carter', 'Lily', 'Dylan', 'Zoey', 'Leo', 'Mila', 'Caleb', 'Paisley', 'Christopher', 'Everly', 'Samuel', 'Aaliyah', 'Jack', 'Savannah', 'Nicholas', 'Anna', 'Leo', 'Bella', 'David', 'Caroline', 'Joseph', 'Genesis', 'Anthony', 'Kennedy', 'Oliver', 'Ellie', 'Daniel', 'Scarlett', 'Gabriel', 'Zoey', 'Caleb', 'Penelope', 'Dylan', 'Riley', 'Jackson', 'Madelyn'];
    -- 英語圏のファミリーネーム * 100
    last_names TEXT[] := ARRAY['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Miller', 'Davis', 'Garcia', 'Rodriguez', 'Martinez', 'Hernandez', 'Lopez', 'Gonzalez', 'Wilson', 'Anderson', 'Thomas', 'Taylor', 'Moore', 'Jackson', 'Martin', 'Lee', 'Perez', 'Thompson', 'White', 'Harris', 'Sanchez', 'Clark', 'Ramirez', 'Lewis', 'Robinson', 'Walker', 'Hall', 'Allen', 'Young', 'Hernandez', 'King', 'Wright', 'Hill', 'Scott', 'Green', 'Adams', 'Baker', 'Nelson', 'Carter', 'Mitchell', 'Perez', 'Roberts', 'Turner', 'Phillips', 'Campbell', 'Parker', 'Evans', 'Edwards', 'Collins', 'Stewart', 'Sanchez', 'Morris', 'Rogers', 'Reed', 'Cook', 'Morgan', 'Bell', 'Murphy', 'Bailey', 'Rivera', 'Cooper', 'Cox', 'Howard', 'Ward', 'Torres', 'Peterson', 'Gray', 'Ramirez', 'James', 'Watson', 'Brooks', 'Kelly', 'Sanders', 'Price', 'Bennett', 'Wood', 'Barnes', 'Ross', 'Henderson', 'Coleman', 'Jenkins', 'Perry', 'Powell', 'Long', 'Patterson', 'Hughes', 'Flores', 'Washington', 'Butler', 'Simmons', 'Foster', 'Gonzales', 'Bryant', 'Alexander', 'Russell'];
    random_index INT;
    random_name TEXT;
BEGIN
    random_index := floor(random() * array_length(first_names, 1) + 1);
    random_name := first_names[random_index];
    random_index := floor(random() * array_length(last_names, 1) + 1);
    random_name := random_name || ' ' || last_names[random_index];
    RETURN random_name;
END;
$$ LANGUAGE plpgsql;

-- ランダムなメールアドレスを生成
CREATE OR REPLACE FUNCTION generate_random_email()
RETURNS TEXT AS $$
DECLARE
    aliases TEXT[] := ARRAY['', '+local', '+develop', '+staging', '+production'];
    separate_chars TEXT[] := ARRAY['.', '_', '-'];
    domains TEXT[] := ARRAY['gmail.com', 'yahoo.com', 'hotmail.com', 'outlook.com', 'aol.com', 'icloud.com', 'zoho.com', 'protonmail.com', 'gmx.com', 'mail.com'];
    random_index INT;
    alias TEXT;
    separate_char TEXT;
    domain TEXT;
    user_name TEXT;
    random_email TEXT;
BEGIN
    -- random_index := floor(random() * array_length(aliases, 1) + 1);
    -- alias := aliases[random_index];
    -- random_index := floor(random() * array_length(separate_chars, 1) + 1);
    -- separate_char := separate_chars[random_index];
    -- user_name := lower(replace(generate_random_name(), ' ', separate_char));
    -- random_index := floor(random() * array_length(domains, 1) + 1);
    -- domain := domains[random_index];
    -- random_email := user_name || alias || '@' || domains[random_index];
    --
    -- NOTE: ユーザー名を基準にメールアドレスを生成しようと思ったが、ほぼ確実に重複し、ユニーク制約に違反するので、UUIDを使うことにした。
    random_index := floor(random() * array_length(domains, 1) + 1);
    random_email := lower(replace(generate_random_name(), ' ', '-')) || '@' || domains[random_index];
    random_email := gen_random_uuid() || '@' || domains[random_index];
    RETURN random_email;
END;
$$ LANGUAGE plpgsql;

-- 10,000,000件のレコードをusersテーブルにInsert
INSERT INTO users (name, email, password, deleted)
SELECT
    generate_random_name(),
    generate_random_email(),
    'password',
    CASE
        WHEN (row_number() OVER ()) % 100 = 0 THEN true
        ELSE false
    END
FROM generate_series(1, 1000000);
