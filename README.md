## Setup

You'll need the following:

- `RPC URL`: A URL to connect to the blockchain. You can get one for free from [Alchemy](https://www.alchemy.com/).
- `Private Key`: A private key from your wallet. You can get a private key from a new [Metamask](https://metamask.io/) account

## Deploying

- deploy and verify:

`forge script script/EthernautExperience.s.sol:MyScript --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv`

## Minting

- set approved minter(s):

`cast send --rpc-url $RPC_URL --private-key $PRIVATE_KEY $CONTRACT_ADDRESS "setApprovedMinter(address,bool)" ${MINTER_ADDRESS} "true" --from $FROM_ADDRESS`

- mint:

`cast send --rpc-url $RPC_URL --private-key $PRIVATE_KEY $CONTRACT_ADDRESS "mint(address, uint256)" ${MINTER_ADDRESS} ${MINT_VALUE} --from $FROM_ADDRESS`

- query balance:

`cast call --rpc-url $RPC_URL $CONTRACT_ADDRESS "balanceOf(address)(uint256)" ${MINTER_ADDRESS} --from $FROM_ADDRESS`

## Gas Report

![gas report](./gas-report.png)
