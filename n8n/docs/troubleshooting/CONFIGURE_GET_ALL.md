# Configure "Get Old Messages" Node

## ⚠️ Current Issue
- Operation is set to **"Get"** (gets one message by ID)
- Message ID field has an error (red warning icon)
- Need to change to **"Get All"** to retrieve multiple messages

## ✅ Fix Steps

### Step 1: Change Operation

1. **Find "Operation" dropdown** (currently shows "Get")
2. **Click the dropdown**
3. **Select "Get All"** (not "Get")

### Step 2: After Changing to "Get All"

The fields will change. You'll see:

1. **"Return All"**:
   - Set to **"No"** (we want to limit)

2. **"Limit"**:
   - Set to **`10`** (for testing!)

3. **"Additional Fields"** section:
   - Click **"Add Field"**
   - Select **"Q"** (Search Query)
   - Enter: `before:2024/1/1`
   - This searches for emails before 2024

### Step 3: Remove Message ID

- The **"Message ID"** field should disappear when you change to "Get All"
- If it doesn't, just ignore it or clear it

### Step 4: Save and Test

1. **Click "Execute step"** button (top right of node)
2. **Check the OUTPUT panel** on the right
3. **You should see** a list of old emails

## 📋 Complete Configuration

**"Get Old Messages" Node:**
- ✅ Credential: Gmail account
- ✅ Resource: Message
- ✅ Operation: **Get All** (NOT "Get"!)
- ✅ Return All: No
- ✅ Limit: 10
- ✅ Q (Search Query): `before:2024/1/1`

## 🎯 What Happens Next

After executing:
1. Node retrieves up to 10 emails before 2024
2. Data flows to "Filter Messages by Year" node
3. Then to "Delete Message" node (if connected)

---

**Change to "Get All" and add the search query! 🚀**

