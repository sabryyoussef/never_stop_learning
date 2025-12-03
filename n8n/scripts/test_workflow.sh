#!/bin/bash
# Test workflow validation script

echo "🧪 Testing n8n Workflow: List All Documents"
echo "=============================================="
echo ""

# Check if workflow file exists
if [ ! -f "list_all_documents.json" ]; then
    echo "❌ Workflow file not found!"
    exit 1
fi

# Validate JSON syntax
echo "1️⃣ Validating JSON syntax..."
if python3 -m json.tool list_all_documents.json > /dev/null 2>&1; then
    echo "   ✅ JSON syntax is valid"
else
    echo "   ❌ JSON syntax error"
    exit 1
fi

# Check workflow structure
echo ""
echo "2️⃣ Validating workflow structure..."
NODE_COUNT=$(python3 -c "import json; wf=json.load(open('list_all_documents.json')); print(len(wf.get('nodes', [])))")
echo "   ✅ Found $NODE_COUNT nodes"

# Check for required nodes
echo ""
echo "3️⃣ Checking node types..."
python3 << 'EOF'
import json

with open('list_all_documents.json') as f:
    wf = json.load(f)

required_types = {
    'n8n-nodes-base.manualTrigger': False,
    'n8n-nodes-base.googleDrive': False,
    'n8n-nodes-base.set': False
}

for node in wf.get('nodes', []):
    node_type = node.get('type', '')
    if node_type in required_types:
        required_types[node_type] = True
    print(f"   - {node.get('name', 'Unknown')}: {node_type} v{node.get('typeVersion', '?')}")

print("")
all_found = all(required_types.values())
if all_found:
    print("   ✅ All required node types found")
else:
    missing = [k for k, v in required_types.items() if not v]
    print(f"   ⚠️  Missing node types: {', '.join(missing)}")
EOF

# Check connections
echo ""
echo "4️⃣ Validating connections..."
CONN_COUNT=$(python3 -c "import json; wf=json.load(open('list_all_documents.json')); print(len(wf.get('connections', {})))")
echo "   ✅ Found $CONN_COUNT connection groups"

# Final summary
echo ""
echo "=============================================="
echo "✅ Workflow validation complete!"
echo ""
echo "📝 Next steps:"
echo "   1. Import workflow into n8n UI: http://localhost:5678"
echo "   2. Configure Google Drive OAuth credentials"
echo "   3. Test the workflow execution"
echo ""

