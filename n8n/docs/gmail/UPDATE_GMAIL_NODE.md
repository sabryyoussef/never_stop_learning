# Update Gmail Node to Get "Get All" Operation

## ⚠️ Issue
Your Gmail node only shows "Get" operation, not "Get All".

## ✅ Solution: Update Node Version

### Step 1: Update the Node

1. **See the yellow banner?** It says:
   > "New node version available: get the latest version with added features from the nodes panel."

2. **Click on the banner** or:
   - Close the node configuration
   - Right-click on the "Get Old Messages" node
   - Select **"Update node version"** or similar option
   - Or delete the node and add a new Gmail node (it will use latest version)

### Step 2: Add New Gmail Node (Alternative)

If you can't update:

1. **Delete the current "Get Old Messages" node**
2. **Add a new Gmail node:**
   - Click **"+"** button
   - Search for **"Gmail"**
   - Add **"Gmail"** node
   - It should have the latest version with "Get All"

### Step 3: Configure New Node

1. **Resource:** Message
2. **Operation:** Should now show **"Get All"** ✅
3. **Return All:** No
4. **Limit:** 10
5. **Additional Fields → Q:** `before:2024/1/1`

## 🔧 If Still No "Get All"

We can create a workflow using HTTP Request node to call Gmail API directly. Let me know if updating doesn't work!

---

**Try updating the node version first! 🚀**

