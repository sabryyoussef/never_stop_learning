# Fix: Get Old Messages Node Configuration

## ⚠️ Issue
The "Get Old Messages" node has the wrong operation selected!

**Current (Wrong):**
- Operation: **Delete** ❌
- Message ID: 172ce2c4a72cc243

**Should Be:**
- Operation: **Get All** ✅
- No Message ID needed

## ✅ Fix Steps

### Step 1: Change Operation

1. **In the "Get Old Messages" node:**
   - Find **"Operation"** dropdown
   - Currently shows: **"Delete"**
   - **Change it to:** **"Get All"**

### Step 2: Configure Get All Settings

After changing to "Get All", you'll see:

1. **"Return All"**: 
   - Set to **"No"** (we want to limit for testing)

2. **"Limit"**:
   - Set to **`10`** (for testing - start small!)

3. **"Options"** → **"Q"** (Search Query):
   - Enter: `before:2024/1/1`
   - Or use: `={{ $('Set Configuration').item.json.searchQuery }}`
   - This searches for emails before 2024

### Step 3: Verify Node Order

Make sure your workflow nodes are in this order:

1. **"Set Configuration"** - Sets search parameters
2. **"Get Old Messages"** - Operation: **Get All** ✅
3. **"Filter Messages by Year"** - Filters the results
4. **"Delete Message"** - Operation: **Delete** ✅ (separate node)

## 📋 Complete Configuration

### "Get Old Messages" Node:
- **Credential:** Gmail account ✅
- **Resource:** Message ✅
- **Operation:** **Get All** (NOT Delete!)
- **Return All:** No
- **Limit:** 10 (for testing)
- **Q (Search Query):** `before:2024/1/1`

### "Delete Message" Node (Separate Node):
- **Credential:** Gmail account ✅
- **Resource:** Message ✅
- **Operation:** Delete ✅
- **Message ID:** `={{ $json.messageId }}` (from previous node)

## 🎯 Quick Fix

1. **Change "Operation" from "Delete" to "Get All"**
2. **Set "Limit" to 10**
3. **Add search query:** `before:2024/1/1`
4. **Save/Close the node**
5. **Test the workflow**

---

**Change operation to "Get All" and you're good to go! 🚀**

