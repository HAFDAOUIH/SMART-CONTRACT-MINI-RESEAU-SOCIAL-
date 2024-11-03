# MiniSocial Smart Contract

MiniSocial is a decentralized social media platform built on the Ethereum blockchain. This smart contract allows users to publish, retrieve, and delete messages on-chain, offering a transparent and immutable way to store and manage messages.

## Features

- **Publish Messages**: Users can publish messages to the blockchain.
- **Retrieve Messages**: Anyone can retrieve messages by their index.
- **Total Message Count**: Retrieve the total number of messages.
- **Delete Own Messages**: Users can delete only their own messages.
- **User Message Count**: Track the number of messages each user has published.

## Contract Architecture

The contract is written in Solidity and includes the following main components:

- **Struct `Post`**: Represents a message, including:
  - `message`: The content of the message (string).
  - `author`: The address of the message author.
  - `timestamp`: The time the message was published.

- **Dynamic Array `posts`**: Stores all `Post` structures.

- **Mapping `userPostCount`**: Maps user addresses to their respective message counts.

- **Events**:
  - `NewPost`: Emitted when a new message is published.
  - `PostDeleted`: Emitted when a message is deleted.

- **Modifiers**:
  - `validMessage`: Ensures that messages are non-empty and within the maximum length (280 characters).

## Functions

- **publishPost(string memory _message)**: Publishes a new message on the blockchain.
- **getPost(uint index)**: Retrieves a specific message by its index.
- **getTotalPosts()**: Returns the total number of messages.
- **deletePost(uint index)**: Allows users to delete their own messages by index.
- **getUserPostCount(address user)**: Returns the number of messages a specific user has published.

## Prerequisites

To deploy and interact with this contract, you will need:

- **MetaMask**: Set up with the Sepolia test network.
- **Remix IDE**: For compiling, deploying, and testing the contract.
- **SepoliaETH**: Test Ether to cover gas fees, obtainable from a faucet.

## Deployment and Testing Steps

1. **Configure MetaMask**:
   - Ensure your MetaMask wallet is set to the Sepolia test network.
   - Obtain SepoliaETH from a faucet to cover transaction fees.

2. **Deploy the Contract**:
   - Open the contract in Remix IDE.
   - Select "Injected Provider - MetaMask" as the environment.
   - Compile and deploy the contract.
   - Confirm the deployment transaction in MetaMask.

3. **Testing the Functions**:
   - **Publish a Post**: Call `publishPost` with a sample message. Verify the transaction and event on Etherscan.
   - **Retrieve a Post**: Use `getPost` with the index of a published message to view its content, author, and timestamp.
   - **Check Total Posts**: Call `getTotalPosts` to view the number of messages published.
   - **Delete a Post**: Use `deletePost` to delete a message you authored. Confirm the deletion event on Etherscan.
   - **Check User Post Count**: Use `getUserPostCount` with your address to view your message count.

## Example Usage

Here’s an example of how to publish and retrieve a post:

```solidity
// Publish a new post
publishPost("Hello, blockchain!");

// Retrieve the first post
(string memory message, address author, uint256 timestamp) = getPost(0);```

## Events

- **NewPost**: Emitted when a user publishes a new message.
  - `author`: Address of the user who published the message.
  - `message`: The content of the message.
  - `postId`: The ID of the message in the array.
  - `timestamp`: The time the message was published.

- **PostDeleted**: Emitted when a user deletes their own message.
  - `postId`: The ID of the deleted message.
  - `author`: Address of the user who deleted the message.

## Security Considerations

- **Only Author Can Delete**: The `deletePost` function uses a check to ensure that only the original author can delete their post.
- **Message Validation**: The `validMessage` modifier ensures that each message is within the maximum allowed length and is not empty.




This `README.md` file now includes all sections, including **Events** and **Security Considerations**, formatted for clarity. Let me know if you need any additional modifications!

