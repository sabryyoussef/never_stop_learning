# Add Search Query to Get Many

## ✅ Current Configuration (Correct!)

- ✅ Operation: **Get Many** (perfect - this works!)
- ✅ Return All: **Off** (correct)
- ✅ Limit: **10** (good for testing!)
- ✅ Credential: Gmail account (set)

## 🎯 Final Step: Add Search Query

### Step 1: Add Search Query Field

1. **Find "Additional Fields" section** (below Limit)
2. **Click "Add Field"** button (with dropdown arrow)
3. **Select "Q"** from the dropdown
   - This is the Gmail search query field

### Step 2: Enter Search Query

1. **In the "Q" field that appears:**
   - Enter: `before:2024/1/1`
   - This searches for emails before January 1, 2024

### Step 3: Execute

1. **Click "Execute step"** button (top right, orange button)
2. **Check OUTPUT panel** on the right
3. **You should see** a list of old emails!

## 📋 Complete Configuration

- ✅ Credential: Gmail account
- ✅ Resource: Message
- ✅ Operation: **Get Many** ✅
- ✅ Return All: Off
- ✅ Limit: 10
- ✅ **Q (Search Query):** `before:2024/1/1` ← **Add this!**

## 🎯 What Happens Next

After executing:
1. Node retrieves up to 10 emails before 2024
2. Data flows to next node (Filter Messages)
3. Then to Delete node (if connected)

---

**Add the search query and execute! You're almost there! 🚀**

