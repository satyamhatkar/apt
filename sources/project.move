module MyModule::NFTBookClub {

    use aptos_framework::signer;
    use std::vector;

    /// Struct representing a book NFT.
    struct BookNFT has store, key {
        owner: address,         // Address of the book owner
        title: vector<u8>,      // Title of the book
        is_completed: bool,     // Whether the book has been completed by the reader
    }

    /// Function to mint a book as an NFT.
    public fun mint_book(owner: &signer, title: vector<u8>) {
        let book = BookNFT {
            owner: signer::address_of(owner),
            title,
            is_completed: false,
        };
        move_to(owner, book);
    }

    /// Function to mark the book as completed and reward the reader.
    public fun complete_book(reader: &signer, book_owner: address) acquires BookNFT {
        let book = borrow_global_mut<BookNFT>(book_owner);

        // Ensure the book has not been completed yet
        assert!(!book.is_completed, 1);

        // Mark the book as completed
        book.is_completed = true;

        // Note: Actual reward logic (e.g., token transfer) is not implemented for simplicity
    }
}
