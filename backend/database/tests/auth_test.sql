-- ==========================================
-- AUTH SCHEMA TESTS
-- ==========================================

SET search_path TO auth;

------------------------------------------------
-- Verify Seed Roles
------------------------------------------------

SELECT *
FROM roles;

------------------------------------------------
-- Insert Test User
------------------------------------------------

INSERT INTO users
(
    role_id,
    email,
    full_name
)
VALUES
(
    (
        SELECT role_id
        FROM roles
        WHERE role_name='Viewer'
    ),
    'test@omnibrain.ai',
    'Test User'
);

------------------------------------------------
-- Verify Insert
------------------------------------------------

SELECT *
FROM users;

------------------------------------------------
-- Duplicate Email Test
------------------------------------------------

INSERT INTO users
(
    role_id,
    email,
    full_name
)
VALUES
(
    (
        SELECT role_id
        FROM roles
        WHERE role_name='Viewer'
    ),
    'test@omnibrain.ai',
    'Another User'
);

-- Expected:
-- UNIQUE constraint violation

------------------------------------------------
-- Foreign Key Test
------------------------------------------------

INSERT INTO users
(
    role_id,
    email,
    full_name
)
VALUES
(
    gen_random_uuid(),
    'wrong@omnibrain.ai',
    'Wrong User'
);

-- Expected:
-- Foreign key violation

------------------------------------------------
-- Active Users
------------------------------------------------

SELECT *

FROM users

WHERE is_active=TRUE;