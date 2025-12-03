-- =====================================================
-- Sync Kareem's Groups to Match Ian's Groups
-- =====================================================
-- This script will make Kareem have exactly the same groups as Ian
-- 
-- WARNING: This will remove all existing groups from Kareem and replace
-- them with Ian's groups. Make sure you have a backup!
--
-- Users:
-- - Ian: c.badlon@freezoner.net (user ID: 8)
-- - Kareem: k.alsawah@freezoner.net (user ID: 55)
-- =====================================================

-- Step 1: Verify user IDs
SELECT 
    u.id,
    u.login,
    p.name as user_name
FROM res_users u
LEFT JOIN res_partner p ON u.partner_id = p.id
WHERE u.login IN ('c.badlon@freezoner.net', 'k.alsawah@freezoner.net')
ORDER BY u.login;

-- Step 2: Show current group count for both users
SELECT 
    u.login,
    p.name as user_name,
    COUNT(DISTINCT gu.gid) as current_group_count
FROM res_users u
LEFT JOIN res_partner p ON u.partner_id = p.id
LEFT JOIN res_groups_users_rel gu ON u.id = gu.uid
WHERE u.login IN ('c.badlon@freezoner.net', 'k.alsawah@freezoner.net')
GROUP BY u.id, u.login, p.name
ORDER BY u.login;

-- Step 3: Show groups that Ian has but Kareem doesn't (will be added)
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

-- Step 4: Show groups that Kareem has but Ian doesn't (will be removed)
SELECT 
    g.id as group_id,
    g.name->>'en_US' as group_name,
    COALESCE(gc.name->>'en_US', 'No Category') as category_name
FROM res_users u
INNER JOIN res_groups_users_rel gu ON u.id = gu.uid
INNER JOIN res_groups g ON gu.gid = g.id
LEFT JOIN ir_module_category gc ON g.category_id = gc.id
WHERE u.login = 'k.alsawah@freezoner.net'
    AND g.id NOT IN (
        SELECT g2.id
        FROM res_users u2
        INNER JOIN res_groups_users_rel gu2 ON u2.id = gu2.uid
        INNER JOIN res_groups g2 ON gu2.gid = g2.id
        WHERE u2.login = 'c.badlon@freezoner.net'
    )
ORDER BY category_name, group_name;

-- =====================================================
-- ACTUAL SYNC OPERATIONS
-- =====================================================
-- Uncomment and run these after reviewing the above queries
-- =====================================================

-- Step 5: Remove ALL groups from Kareem
-- DELETE FROM res_groups_users_rel 
-- WHERE uid = (SELECT id FROM res_users WHERE login = 'k.alsawah@freezoner.net');

-- Step 6: Add all of Ian's groups to Kareem
-- INSERT INTO res_groups_users_rel (gid, uid)
-- SELECT 
--     gu.gid,
--     (SELECT id FROM res_users WHERE login = 'k.alsawah@freezoner.net') as uid
-- FROM res_users u
-- INNER JOIN res_groups_users_rel gu ON u.id = gu.uid
-- WHERE u.login = 'c.badlon@freezoner.net'
-- ON CONFLICT DO NOTHING;

-- =====================================================
-- ALTERNATIVE: Single transaction approach (safer)
-- =====================================================
-- This does everything in one transaction
-- =====================================================

BEGIN;

-- Remove all groups from Kareem
DELETE FROM res_groups_users_rel 
WHERE uid = (SELECT id FROM res_users WHERE login = 'k.alsawah@freezoner.net');

-- Add all of Ian's groups to Kareem
INSERT INTO res_groups_users_rel (gid, uid)
SELECT 
    gu.gid,
    (SELECT id FROM res_users WHERE login = 'k.alsawah@freezoner.net') as uid
FROM res_users u
INNER JOIN res_groups_users_rel gu ON u.id = gu.uid
WHERE u.login = 'c.badlon@freezoner.net'
ON CONFLICT DO NOTHING;

-- Verify the result
SELECT 
    u.login,
    p.name as user_name,
    COUNT(DISTINCT gu.gid) as group_count
FROM res_users u
LEFT JOIN res_partner p ON u.partner_id = p.id
LEFT JOIN res_groups_users_rel gu ON u.id = gu.uid
WHERE u.login IN ('c.badlon@freezoner.net', 'k.alsawah@freezoner.net')
GROUP BY u.id, u.login, p.name
ORDER BY u.login;

-- If everything looks good, commit:
-- COMMIT;
-- If something is wrong, rollback:
-- ROLLBACK;

