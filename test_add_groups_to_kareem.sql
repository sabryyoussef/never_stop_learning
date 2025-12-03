-- =====================================================
-- Test: Add Missing Groups to Kareem (Incremental)
-- =====================================================
-- This script helps you add groups one by one or in small batches
-- to test before doing a full sync
-- =====================================================

-- Step 1: List ALL groups that Ian has but Kareem doesn't
SELECT 
    g.id as group_id,
    g.name->>'en_US' as group_name,
    COALESCE(gc.name->>'en_US', 'No Category') as category_name
FROM res_users u
INNER JOIN res_groups_users_rel gu ON u.id = gu.uid
INNER JOIN res_groups g ON gu.gid = g.id
LEFT JOIN ir_module_category gc ON g.category_id = gc.id
WHERE u.login = 'c.badlon@freezoner.net'
    AND g.id NOT IN (
        SELECT g2.id
        FROM res_users u2
        INNER JOIN res_groups_users_rel gu2 ON u2.id = gu2.uid
        INNER JOIN res_groups g2 ON gu2.gid = g2.id
        WHERE u2.login = 'k.alsawah@freezoner.net'
    )
ORDER BY category_name, group_name;

-- =====================================================
-- Step 2: TEST - Add 2-3 specific groups
-- =====================================================
-- First, let's pick some simple groups to test with
-- Based on the output, here are some good test candidates:
-- =====================================================

-- Option A: Add by Group Name (pick 2-3 from the list above)
-- Example: Adding "Accountant", "Bookkeeper", and "Read-only" groups

BEGIN;

-- Get Kareem's user ID
SELECT id as kareem_user_id, login, (SELECT name FROM res_partner WHERE id = res_users.partner_id) as name
FROM res_users 
WHERE login = 'k.alsawah@freezoner.net';

-- Test 1: Add "Accountant" group to Kareem
INSERT INTO res_groups_users_rel (gid, uid)
SELECT 
    g.id as gid,
    (SELECT id FROM res_users WHERE login = 'k.alsawah@freezoner.net') as uid
FROM res_groups g
WHERE g.name->>'en_US' = 'Accountant'
    AND g.id NOT IN (
        SELECT gu.gid 
        FROM res_groups_users_rel gu
        INNER JOIN res_users u ON gu.uid = u.id
        WHERE u.login = 'k.alsawah@freezoner.net'
    )
ON CONFLICT DO NOTHING;

-- Test 2: Add "Bookkeeper" group to Kareem
INSERT INTO res_groups_users_rel (gid, uid)
SELECT 
    g.id as gid,
    (SELECT id FROM res_users WHERE login = 'k.alsawah@freezoner.net') as uid
FROM res_groups g
WHERE g.name->>'en_US' = 'Bookkeeper'
    AND g.id NOT IN (
        SELECT gu.gid 
        FROM res_groups_users_rel gu
        INNER JOIN res_users u ON gu.uid = u.id
        WHERE u.login = 'k.alsawah@freezoner.net'
    )
ON CONFLICT DO NOTHING;

-- Test 3: Add "Read-only" group to Kareem
INSERT INTO res_groups_users_rel (gid, uid)
SELECT 
    g.id as gid,
    (SELECT id FROM res_users WHERE login = 'k.alsawah@freezoner.net') as uid
FROM res_groups g
WHERE g.name->>'en_US' = 'Read-only'
    AND g.id NOT IN (
        SELECT gu.gid 
        FROM res_groups_users_rel gu
        INNER JOIN res_users u ON gu.uid = u.id
        WHERE u.login = 'k.alsawah@freezoner.net'
    )
ON CONFLICT DO NOTHING;

-- Verify: Check if groups were added
SELECT 
    u.login,
    p.name as user_name,
    g.name->>'en_US' as group_name,
    COALESCE(gc.name->>'en_US', 'No Category') as category_name
FROM res_users u
LEFT JOIN res_partner p ON u.partner_id = p.id
INNER JOIN res_groups_users_rel gu ON u.id = gu.uid
INNER JOIN res_groups g ON gu.gid = g.id
LEFT JOIN ir_module_category gc ON g.category_id = gc.id
WHERE u.login = 'k.alsawah@freezoner.net'
    AND g.name->>'en_US' IN ('Accountant', 'Bookkeeper', 'Read-only')
ORDER BY g.name->>'en_US';

-- If everything looks good:
COMMIT;
-- If something is wrong:
-- ROLLBACK;

-- =====================================================
-- Alternative: Add by Group ID (more precise)
-- =====================================================
-- First run Step 1 to get the group IDs, then use them here:
-- =====================================================

/*
BEGIN;

-- Example: Add groups by their IDs (replace with actual IDs from Step 1)
-- Let's say we want to add groups with IDs: 123, 456, 789

INSERT INTO res_groups_users_rel (gid, uid)
SELECT 
    g.id as gid,
    (SELECT id FROM res_users WHERE login = 'k.alsawah@freezoner.net') as uid
FROM res_groups g
WHERE g.id IN (123, 456, 789)  -- Replace with actual group IDs
    AND g.id NOT IN (
        SELECT gu.gid 
        FROM res_groups_users_rel gu
        INNER JOIN res_users u ON gu.uid = u.id
        WHERE u.login = 'k.alsawah@freezoner.net'
    )
ON CONFLICT DO NOTHING;

-- Verify
SELECT 
    u.login,
    p.name as user_name,
    g.id as group_id,
    g.name->>'en_US' as group_name
FROM res_users u
LEFT JOIN res_partner p ON u.partner_id = p.id
INNER JOIN res_groups_users_rel gu ON u.id = gu.uid
INNER JOIN res_groups g ON gu.gid = g.id
WHERE u.login = 'k.alsawah@freezoner.net'
    AND g.id IN (123, 456, 789)  -- Replace with actual group IDs
ORDER BY g.name->>'en_US';

COMMIT;
*/

-- =====================================================
-- Helper: Check current group count after test
-- =====================================================
SELECT 
    u.login,
    p.name as user_name,
    COUNT(DISTINCT gu.gid) as total_groups
FROM res_users u
LEFT JOIN res_partner p ON u.partner_id = p.id
LEFT JOIN res_groups_users_rel gu ON u.id = gu.uid
WHERE u.login IN ('c.badlon@freezoner.net', 'k.alsawah@freezoner.net')
GROUP BY u.id, u.login, p.name
ORDER BY u.login;


