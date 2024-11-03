// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title MiniSocial
 * @dev Un contrat simple de réseau social permettant la publication et la lecture de messages
 * @notice Ce contrat permet aux utilisateurs de publier des messages publics sur la blockchain
 */
contract MiniSocial {
    // Structure pour représenter un post
    struct Post {
        string message;
        address author;
        uint256 timestamp;  // Ajout d'un horodatage
    }
    
    // Tableau dynamique pour stocker tous les posts
    Post[] private posts;
    
    // Limite de taille pour les messages
    uint256 public constant MAX_MESSAGE_LENGTH = 280;
    
    // Événements
    event NewPost(address indexed author, string message, uint256 indexed postId, uint256 timestamp);
    event PostDeleted(uint256 indexed postId, address indexed author);
    
    // Mapping pour suivre le nombre de posts par utilisateur
    mapping(address => uint256) public userPostCount;
    
    // Modificateur pour vérifier la validité du message
    modifier validMessage(string memory _message) {
        require(bytes(_message).length > 0, "Le message ne peut pas etre vide");
        require(bytes(_message).length <= MAX_MESSAGE_LENGTH, "Message trop long");
        _;
    }
    
    /**
     * @dev Publie un nouveau message
     * @param _message Le message à publier
     * @notice Le message doit respecter la limite de taille
     */
    function publishPost(string memory _message) 
        public 
        validMessage(_message) 
    {
        Post memory newPost = Post({
            message: _message,
            author: msg.sender,
            timestamp: block.timestamp
        });
        
        posts.push(newPost);
        userPostCount[msg.sender]++;
        
        emit NewPost(msg.sender, _message, posts.length - 1, block.timestamp);
    }
    
    /**
     * @dev Récupère un post spécifique
     * @param index L'index du post à récupérer
     * @return message Le contenu du message
     * @return author L'adresse de l'auteur
     * @return timestamp L'horodatage du post
     */
    function getPost(uint index) 
        public 
        view 
        returns (string memory message, address author, uint256 timestamp) 
    {
        require(index < posts.length, "Index invalide");
        Post storage post = posts[index];
        return (post.message, post.author, post.timestamp);
    }
    
    /**
     * @dev Retourne le nombre total de posts
     * @return Le nombre total de posts
     */
    function getTotalPosts() public view returns (uint) {
        return posts.length;
    }
    
    /**
     * @dev Permet à un utilisateur de supprimer son propre post
     * @param index L'index du post à supprimer
     */
    function deletePost(uint index) public {
        require(index < posts.length, "Index invalide");
        require(posts[index].author == msg.sender, "Seul l'auteur peut supprimer son post");
        
        emit PostDeleted(index, msg.sender);
        
        // Supprime le post en le remplaçant par le dernier post du tableau
        posts[index] = posts[posts.length - 1];
        posts.pop();
        userPostCount[msg.sender]--;
    }
    
    /**
     * @dev Récupère le nombre de posts d'un utilisateur spécifique
     * @param user L'adresse de l'utilisateur
     * @return Le nombre de posts de l'utilisateur
     */
    function getUserPostCount(address user) public view returns (uint256) {
        return userPostCount[user];
    }
}