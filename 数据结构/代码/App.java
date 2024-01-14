import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

// 书籍类
class Book {
    private int bookId; // 新增书籍ID
    private String title;
    private String author;
    private boolean available;

    private static int nextBookId = 1; // 用于生成唯一的书籍ID

    public Book(String title, String author) {
        this.bookId = nextBookId++;
        this.title = title;
        this.author = author;
        this.available = true;
    }

    public int getBookId() {
        return bookId;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public boolean isAvailable() {
        return available;
    }

    // 新增方法：更新书籍信息
    public void updateInformation(String newTitle, String newAuthor, boolean newAvailable) {
        this.title = newTitle;
        this.author = newAuthor;
        this.available = newAvailable;
    }

    @Override
    public String toString() {
        return title + " by " + author + " - " + (available ? "Available" : "Not Available");
    }
}

// 图书馆类
class Library {
    private ArrayList<Book> books;

    public Library() {
        this.books = new ArrayList<>();
    }

    public void addBook(String title, String author) {
        Book book = new Book(title, author);
        books.add(book);
    }

    public Book findBook(int id) {
        for (Book book : books) {
            if (book.getBookId()==id) {
                return book;
            }
        }
        return null;
    }

    public boolean borrowBook(int id) {
        Book book = findBook(id);
        if (book != null && book.isAvailable()) {
            book.updateInformation(book.getTitle(), book.getAuthor(), false);
            return true;
        }
        return false;
    }

    public boolean returnBook(int id) {
        Book book = findBook(id);
        if (book != null && !book.isAvailable()) {
            book.updateInformation(book.getTitle(), book.getAuthor(), true);
            return true;
        }
        return false;
    }

    public ArrayList<Book> getAllBooks() {
        return books;
    }

    public void sortBooks(Comparator<Book> comparator) {
        Collections.sort(books, comparator);
    }

    public ArrayList<Book> searchBooks(String condition, String value) {
        ArrayList<Book> result = new ArrayList<>();
        switch (condition) {
            case "Title":
                for (Book book : books) {
                    if (book.getTitle().equalsIgnoreCase(value)) {
                        result.add(book);
                    }
                }
                break;
            case "Author":
                for (Book book : books) {
                    if (book.getAuthor().equalsIgnoreCase(value)) {
                        result.add(book);
                    }
                }
                break;
            case "Availability":
                for (Book book : books) {
                    if ((value.equalsIgnoreCase("Available") && book.isAvailable()) ||
                            (value.equalsIgnoreCase("Not Available") && !book.isAvailable())) {
                        result.add(book);
                    }
                }
                break;
        }
        return result;
    }

    public void deleteBook(Book book) {
        books.remove(book);
    }

    public Book findBookbytitle(String title) {

        for (Book book : books) {
            if (book.getTitle().equalsIgnoreCase(title)) {
                return book;
            }
        }
        return null;

    }
}











// 图书馆管理系统界面
class LibraryGUI extends JFrame {
    private Library library;

    private JTextField titleField;
    private JTextField authorField;
    private JTextArea resultArea;
    private JList<Book> bookList;
    private JComboBox<String> sortComboBox;
    private JButton sortButton;
    private JComboBox<String> searchComboBox;
    private JTextField searchValueField;
    private JButton searchButton;
    private JButton modifyButton;  // 新增修改按钮

    public LibraryGUI() {
        this.library = new Library();
        setTitle("Library Management System");
        setSize(600, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JPanel mainPanel = new JPanel(new BorderLayout());

        JPanel leftPanel = new JPanel(new GridLayout(9, 2));
        JLabel titleLabel = new JLabel("Title:");
        titleField = new JTextField();
        JLabel authorLabel = new JLabel("Author:");
        authorField = new JTextField();
        JButton addButton = new JButton("Add Book");
        // 在左侧面板中添加删除按钮
        JButton deleteButton = new JButton("Delete Book");

        JButton findButton = new JButton("Find Book");
        JButton borrowButton = new JButton("Borrow Book");
        JButton returnButton = new JButton("Return Book");
        modifyButton = new JButton("Modify Book");  // 添加修改按钮

        leftPanel.add(titleLabel);
        leftPanel.add(titleField);
        leftPanel.add(authorLabel);
        leftPanel.add(authorField);
        leftPanel.add(addButton);
        leftPanel.add(deleteButton);
        leftPanel.add(findButton);
        leftPanel.add(borrowButton);
        leftPanel.add(returnButton);
        leftPanel.add(modifyButton);  // 添加修改按钮

        JPanel rightPanel = new JPanel(new BorderLayout());
        JLabel bookListLabel = new JLabel("All Books:");
        resultArea = new JTextArea();
        bookList = new JList<>();
        JScrollPane bookListScrollPane = new JScrollPane(bookList);

        rightPanel.add(bookListLabel, BorderLayout.NORTH);
        rightPanel.add(bookListScrollPane, BorderLayout.CENTER);
        rightPanel.add(resultArea, BorderLayout.SOUTH);

        JPanel sortPanel = new JPanel(new FlowLayout());
        JLabel sortLabel = new JLabel("Sort By:");
        sortComboBox = new JComboBox<>(new String[]{"Title", "Author", "Availability"});
        sortButton = new JButton("Sort");
        sortPanel.add(sortLabel);
        sortPanel.add(sortComboBox);
        sortPanel.add(sortButton);

        JPanel searchPanel = new JPanel(new FlowLayout());
        JLabel searchLabel = new JLabel("Search By:");
        searchComboBox = new JComboBox<>(new String[]{"Title", "Author", "Availability"});
        JLabel searchValueLabel = new JLabel("Value:");
        searchValueField = new JTextField();
        searchValueField.setColumns(15);

        searchButton = new JButton("Search");
        searchPanel.add(searchLabel);
        searchPanel.add(searchComboBox);
        searchPanel.add(searchValueLabel);
        searchPanel.add(searchValueField);
        searchPanel.add(searchButton);












        addButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String title = titleField.getText();
                String author = authorField.getText();
                library.addBook(title, author);
                updateBookList();
                resultArea.setText("Book added: " + title + " by " + author);
                titleField.setText("");
                authorField.setText("");
            }
        });

        deleteButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // 获取选中的书籍
                Book selectedBook = bookList.getSelectedValue();

                // 检查书籍是否为空
                if (selectedBook != null) {
                    // 弹出确认对话框
                    int dialogResult = JOptionPane.showConfirmDialog(null, "Are you sure you want to delete this book?",
                            "Confirm Deletion", JOptionPane.YES_NO_OPTION);

                    // 如果用户确认删除
                    if (dialogResult == JOptionPane.YES_OPTION) {
                        // 从图书馆中删除书籍
                        library.deleteBook(selectedBook);
                        updateBookList();
                        resultArea.setText("Book deleted successfully!");
                    }
                } else {
                    resultArea.setText("Please select a book to delete.");
                }
            }
        });

        findButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String title = titleField.getText();
                Book book = library.findBookbytitle(title);
                if (book != null) {
                    resultArea.setText("Book found: " + book.getTitle() + " by " + book.getAuthor());
                } else {
                    resultArea.setText("Book not found: " + title);
                }
            }
        });

        borrowButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // 获取选中的书籍
                Book selectedBook = bookList.getSelectedValue();

                // 检查书籍是否为空
                if (selectedBook != null) {
                    boolean success = library.borrowBook(selectedBook.getBookId());
                    if (success) {
                        updateBookList();
                        resultArea.setText("Book borrowed: " + selectedBook.getTitle());
                    } else {
                        resultArea.setText("Book not available for borrowing: " + selectedBook.getTitle());
                    }
                } else {
                    resultArea.setText("Please select a book to borrow.");
                }
            }
        });


        returnButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Book selectedBook = bookList.getSelectedValue();

                boolean success = library.returnBook(selectedBook.getBookId());
                if (success) {
                    updateBookList();
                    resultArea.setText("Book returned: " + selectedBook.getTitle());
                } else {
                    resultArea.setText("Book not available for returning: " + selectedBook.getTitle());
                }
            }
        });

        modifyButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // 获取用户输入的标题和作者
                String newTitle = JOptionPane.showInputDialog("Enter the new title (or leave blank to keep the same):");
                String newAuthor = JOptionPane.showInputDialog("Enter the new author (or leave blank to keep the same):");

                // 获取选中的书籍
                Book selectedBook = bookList.getSelectedValue();

                // 检查书籍是否为空
                if (selectedBook != null) {
                    // 更新书籍信息
                    selectedBook.updateInformation(
                            newTitle.equals("") ? selectedBook.getTitle() : newTitle,
                            newAuthor.equals("") ? selectedBook.getAuthor() : newAuthor,
                            selectedBook.isAvailable()
                    );
                    updateBookList();
                    resultArea.setText("Book modified successfully!");
                } else {
                    resultArea.setText("Please select a book to modify.");
                }
            }
        });


        sortButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String selectedSort = (String) sortComboBox.getSelectedItem();
                Comparator<Book> comparator = null;
                switch (selectedSort) {
                    case "Title":
                        comparator = Comparator.comparing(Book::getTitle);
                        break;
                    case "Author":
                        comparator = Comparator.comparing(Book::getAuthor);
                        break;
                    case "Availability":
                        comparator = Comparator.comparing(Book::isAvailable);
                        break;
                }
                if (comparator != null) {
                    library.sortBooks(comparator);
                    updateBookList();
                    resultArea.setText("Books sorted by: " + selectedSort);
                }
            }
        });

        searchButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String selectedSearch = (String) searchComboBox.getSelectedItem();
                String searchValue = searchValueField.getText();
                ArrayList<Book> searchResult = library.searchBooks(selectedSearch, searchValue);
                if (!searchResult.isEmpty()) {
                    StringBuilder searchResultText = new StringBuilder("Search result:\n");
                    for (Book book : searchResult) {
                        searchResultText.append(book.toString()).append("\n");
                    }
                    resultArea.setText(searchResultText.toString());
                } else {
                    resultArea.setText("No matching books found.");
                }
            }
        });

        mainPanel.add(leftPanel, BorderLayout.WEST);
        mainPanel.add(rightPanel, BorderLayout.CENTER);
        mainPanel.add(sortPanel, BorderLayout.SOUTH);
        mainPanel.add(searchPanel, BorderLayout.NORTH);

        add(mainPanel);
        setVisible(true);
    }

    private void updateBookList() {
        ArrayList<Book> allBooks = library.getAllBooks();
        Book[] booksArray = new Book[allBooks.size()];
        allBooks.toArray(booksArray);
        bookList.setListData(booksArray);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                new LibraryGUI();
            }
        });
    }
}