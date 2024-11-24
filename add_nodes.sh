#!/bin/bash

# Define enode addresses
NODE_1="enode://3ad759ce9e43514c83666fd76eff9438d3035c34cdc254bdf442cbecc4d39a467f68543f8ddd33f9a9317b94ed22750b88c42c167812479ad8fe5a03d72a3da0@127.0.0.1:30303"
NODE_2="enode://79aeb9976f4b4eadab06dba35469e85e9d62c2e3bbf8ff9422733f5539488c925ae691e74fd996b9f884e5b69ac03f7c41fdd7d860cb69814f8c4a925f23e054@127.0.0.1:30304"
NODE_3="enode://643acd0b20b81891796b4f602d85b3db2b3768f80ae27ab118d01f370654696f30edb274a54bb59a6915ce30fdfa319d46a70937c3ffa5b78077010a5faa0e1d@127.0.0.1:30305"
NODE_4="enode://9322493059ab4e995eb2c35e29354de67bdf7ee1913a5df18094e52c5f48aca08b6dacaa919d19ca423b68f425baa98361de6b8e534188b98b79296f1217c02e@127.0.0.1:30306"

current_path=$(pwd)

osascript <<EOF
    tell application "iTerm2"
         create window with default profile
         tell current session of current window
              write text "cd $current_path/Node-1"  
              write text "besu --data-path=data --genesis-file=../genesis.json --permissions-nodes-config-file-enabled --permissions-accounts-config-file-enabled --rpc-http-enabled --rpc-http-api=ADMIN,ETH,NET,PERM,IBFT --host-allowlist=\"*\" --rpc-http-cors-origins=\"*\" --profile=ENTERPRISE"
          end tell
    end tell
EOF

osascript <<EOF
    tell application "iTerm2"
         create window with default profile
         tell current session of current window
              write text "cd $current_path/Node-2"  
              write text "besu --data-path=data --genesis-file=../genesis.json --permissions-nodes-config-file-enabled --permissions-accounts-config-file-enabled --rpc-http-enabled --rpc-http-api=ADMIN,ETH,NET,PERM,IBFT --host-allowlist=\"*\" --rpc-http-cors-origins=\"*\" --p2p-port=30304 --rpc-http-port=8546 --profile=ENTERPRISE"
          end tell
    end tell
EOF

osascript <<EOF
    tell application "iTerm2"
         create window with default profile
         tell current session of current window
              write text "cd $current_path/Node-3"  
              write text "besu --data-path=data --genesis-file=../genesis.json --permissions-nodes-config-file-enabled --permissions-accounts-config-file-enabled --rpc-http-enabled --rpc-http-api=ADMIN,ETH,NET,PERM,IBFT --host-allowlist=\"*\" --rpc-http-cors-origins=\"*\" --p2p-port=30305 --rpc-http-port=8547 --profile=ENTERPRISE"
          end tell
    end tell
EOF

osascript <<EOF
    tell application "iTerm2"
         create window with default profile
         tell current session of current window
              write text "cd $current_path/Node-4"  
              write text "besu --data-path=data --genesis-file=../genesis.json --permissions-nodes-config-file-enabled --permissions-accounts-config-file-enabled --rpc-http-enabled --rpc-http-api=ADMIN,ETH,NET,PERM,IBFT --host-allowlist=\"*\" --rpc-http-cors-origins=\"*\" --p2p-port=30306 --rpc-http-port=8548 --profile=ENTERPRISE"
          end tell
    end tell
EOF

# besu --data-path=data --genesis-file=../genesis.json --permissions-nodes-config-file-enabled --permissions-accounts-config-file-enabled --rpc-http-enabled --rpc-http-api=ADMIN,ETH,NET,PERM,IBFT --host-allowlist="*" --rpc-http-cors-origins="*" --profile=ENTERPRISE
# besu --data-path=data --genesis-file=../genesis.json --permissions-nodes-config-file-enabled --permissions-accounts-config-file-enabled --rpc-http-enabled --rpc-http-api=ADMIN,ETH,NET,PERM,IBFT --host-allowlist="*" --rpc-http-cors-origins="*" --p2p-port=30304 --rpc-http-port=8546 --profile=ENTERPRISE
# besu --data-path=data --genesis-file=../genesis.json --permissions-nodes-config-file-enabled --permissions-accounts-config-file-enabled --rpc-http-enabled --rpc-http-api=ADMIN,ETH,NET,PERM,IBFT --host-allowlist="*" --rpc-http-cors-origins="*" --p2p-port=30305 --rpc-http-port=8547 --profile=ENTERPRISE
# besu --data-path=data --genesis-file=../genesis.json --permissions-nodes-config-file-enabled --permissions-accounts-config-file-enabled --rpc-http-enabled --rpc-http-api=ADMIN,ETH,NET,PERM,IBFT --host-allowlist="*" --rpc-http-cors-origins="*" --p2p-port=30306 --rpc-http-port=8548 --profile=ENTERPRISE


# # Add enode URLs for nodes to permissions configuration file
curl -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"perm_addNodesToAllowlist\",\"params\":[[\"$NODE_1\",\"$NODE_2\",\"$NODE_3\",\"$NODE_4\"]], \"id\":1}" http://127.0.0.1:8545
curl -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"perm_addNodesToAllowlist\",\"params\":[[\"$NODE_1\",\"$NODE_2\",\"$NODE_3\",\"$NODE_4\"]], \"id\":1}" http://127.0.0.1:8546
curl -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"perm_addNodesToAllowlist\",\"params\":[[\"$NODE_1\",\"$NODE_2\",\"$NODE_3\",\"$NODE_4\"]], \"id\":1}" http://127.0.0.1:8547
curl -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"perm_addNodesToAllowlist\",\"params\":[[\"$NODE_1\",\"$NODE_2\",\"$NODE_3\",\"$NODE_4\"]], \"id\":1}" http://127.0.0.1:8548

# # Add nodes as peers
curl -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"admin_addPeer\",\"params\":[\"$NODE_1\"],\"id\":1}" http://127.0.0.1:8546
curl -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"admin_addPeer\",\"params\":[\"$NODE_1\"],\"id\":1}" http://127.0.0.1:8547
curl -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"admin_addPeer\",\"params\":[\"$NODE_1\"],\"id\":1}" http://127.0.0.1:8548


curl -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"admin_addPeer\",\"params\":[\"$NODE_2\"],\"id\":1}" http://127.0.0.1:8547
curl -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"admin_addPeer\",\"params\":[\"$NODE_2\"],\"id\":1}" http://127.0.0.1:8548

curl -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"admin_addPeer\",\"params\":[\"$NODE_3\"],\"id\":1}" http://127.0.0.1:8548

# Not a peer Node-5
# besu --data-path=data --bootnodes="enode://3ad759ce9e43514c83666fd76eff9438d3035c34cdc254bdf442cbecc4d39a467f68543f8ddd33f9a9317b94ed22750b88c42c167812479ad8fe5a03d72a3da0@127.0.0.1:30303" --genesis-file=../genesis.json --rpc-http-enabled --rpc-http-api=ADMIN,ETH,NET,PERM,IBFT --host-allowlist="*" --rpc-http-cors-origins="*" --p2p-port=30307 --rpc-http-port=8549

# Check peer count
curl -X POST --data '{"jsonrpc":"2.0","method":"net_peerCount","params":[],"id":1}' localhost:8545

