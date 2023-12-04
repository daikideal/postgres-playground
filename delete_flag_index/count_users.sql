-- 削除フラグをboolean型で表現する場合
SELECT
    COUNT(
        CASE
            WHEN NOT deleted THEN 1
            ELSE NULL
        END
    ) AS not_deleted,
    COUNT(
        CASE
            WHEN deleted THEN 1
            ELSE NULL
        END
    ) AS deleted
FROM
    users;