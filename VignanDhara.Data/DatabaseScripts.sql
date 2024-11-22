USE [VignanDhara]
GO
/****** Object:  Table [dbo].[BookRequests]    Script Date: 22-11-2024 10:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookRequests](
	[BookRequestId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[BookId] [int] NULL,
	[RequestedDate] [date] NULL,
	[RequestStatus] [int] NULL,
	[RejectedReason] [varchar](max) NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[BookRequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 22-11-2024 10:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[BookId] [int] IDENTITY(1,1) NOT NULL,
	[BookName] [varchar](100) NOT NULL,
	[BookDescription] [varchar](max) NULL,
	[Author] [varchar](100) NULL,
	[ISBN] [varchar](20) NULL,
	[PublishedDate] [date] NULL,
	[Publisher] [varchar](100) NULL,
	[Genre] [varchar](50) NULL,
	[TotalBooks] [int] NOT NULL,
	[AvailableBooks] [int] NOT NULL,
	[Rating] [decimal](2, 1) NULL,
	[Status] [int] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BorrowedBooks]    Script Date: 22-11-2024 10:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BorrowedBooks](
	[BorrowedBookId] [int] IDENTITY(1,1) NOT NULL,
	[BookRequestId] [int] NULL,
	[FromDate] [date] NULL,
	[ToDate] [date] NULL,
	[ReturnStatus] [int] NULL,
	[ReturnedDate] [date] NULL,
	[BookCollectedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[BorrowedBookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 22-11-2024 10:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[Status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 22-11-2024 10:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserType] [int] NOT NULL,
	[FirstName] [varchar](40) NULL,
	[LastName] [varchar](15) NULL,
	[EmailId] [nvarchar](255) NOT NULL,
	[Phone] [varchar](15) NULL,
	[Password] [nvarchar](255) NOT NULL,
	[Status] [int] NULL,
	[CreatedDate] [date] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [date] NULL,
	[ModifiedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserType]    Script Date: 22-11-2024 10:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserType](
	[UserTypeId] [int] IDENTITY(1,1) NOT NULL,
	[UserType] [varchar](20) NULL,
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Books] ADD  DEFAULT ((0)) FOR [TotalBooks]
GO
ALTER TABLE [dbo].[Books] ADD  DEFAULT ((0)) FOR [AvailableBooks]
GO
ALTER TABLE [dbo].[Books] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Books] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  StoredProcedure [dbo].[spAddBook]    Script Date: 22-11-2024 10:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddBook]
    @BookName NVARCHAR(255),
    @BookDescription NVARCHAR(MAX),
    @Author NVARCHAR(255),
    @ISBN NVARCHAR(50),
    @PublishedDate DATETIME = NULL,
    @Publisher NVARCHAR(255),
    @Genre NVARCHAR(100),
    @TotalBooks INT,
    @AvailableBooks INT,
    @Rating DECIMAL(3, 2) = NULL,
	@CreatedBy INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Books (BookName, BookDescription, Author, ISBN, PublishedDate, Publisher, Genre, TotalBooks, AvailableBooks, Rating, Status, CreatedDate, CreatedBy)
    VALUES (@BookName, @BookDescription, @Author, @ISBN, @PublishedDate, @Publisher, @Genre, @TotalBooks, @AvailableBooks, @Rating, 1, GETDATE(), @CreatedBy);
    
    SELECT SCOPE_IDENTITY() AS BookId;
END
GO
/****** Object:  StoredProcedure [dbo].[spApproveBookRequest]    Script Date: 22-11-2024 10:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spApproveBookRequest]
    @BookRequestId INT,
    @ApprovedBy INT
AS
BEGIN
    -- Start a transaction to ensure data integrity
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Update the status of the book request
        UPDATE BookRequests
        SET RequestStatus = 5,  -- Assuming 5 represents 'Approved'
            ModifiedBy = @ApprovedBy,
            ModifiedDate = GETDATE()
        WHERE BookRequestId = @BookRequestId;

        -- Insert a record into BorrowedBooks table for the approved request
        INSERT INTO BorrowedBooks (BookRequestId, FromDate, ToDate)
        VALUES (@BookRequestId, GETDATE(), DATEADD(DAY, 14, GETDATE()));

        -- Commit the transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback in case of any errors
        ROLLBACK TRANSACTION;

        -- Optionally, you can handle the error, log it, or re-throw it
        THROW;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[spAuthenticateUser]    Script Date: 22-11-2024 10:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAuthenticateUser]
    @Email NVARCHAR(100),
    @Password NVARCHAR(100)
AS
BEGIN
    DECLARE @count INT;

    SELECT @count = COUNT(EmailId)
    FROM Users
    WHERE EmailId = @Email
    AND Password = @Password
	AND Status = 1;

    IF (@count = 1)
    BEGIN
        SELECT 1 AS ReturnCode;
    END

    ELSE
    BEGIN
        SELECT -1 AS ReturnCode;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[spDeleteBookByBookId]    Script Date: 22-11-2024 10:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeleteBookByBookId]
    @BookId INT,
    @ModifiedBy INT,  -- Pass the user ID who is performing the deletion
    @Result INT OUTPUT  -- Output parameter to return the result (1 for success, 0 for failure)
AS
BEGIN
    -- Check if the book exists
    IF EXISTS (SELECT 1 FROM Books WHERE BookId = @BookId)
    BEGIN
        -- Update the book's status to 3 (soft delete), and update the modified date and modified by fields
        UPDATE Books
        SET Status = 3,  -- Soft delete by setting status
            ModifiedDate = GETDATE(),  -- Update the modified date to current date/time
            ModifiedBy = @ModifiedBy  -- Update the modified by to the user who deleted
        WHERE BookId = @BookId;

        -- Set the output result to 1 for successful update
        SET @Result = 1;
    END
    ELSE
    BEGIN
        -- Set the output result to 0 if the book doesn't exist
        SET @Result = 0;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[spGetAllBooks]    Script Date: 22-11-2024 10:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetAllBooks]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Books
    WHERE Status = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[spGetBookRequests]    Script Date: 22-11-2024 10:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGetBookRequests]
as begin
	set nocount on

	select u.UserId, u.FirstName + ' ' + u.LastName as UserName, br.BookRequestId, b.BookName, br.RequestedDate from Books b 
	join BookRequests br on b.BookId = br.BookId
	join Users u on u.UserId = br.UserId
	where br.RequestStatus = 4
end
GO
/****** Object:  StoredProcedure [dbo].[spGetMyBooks]    Script Date: 22-11-2024 10:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGetMyBooks]
@userId int
as begin
    SET NOCOUNT ON;

	SELECT 
		br.BookId, 
		br.BookRequestId,
		b.BookName, 
		br.RequestedDate, 
		s.Status, 
		br.RejectedReason, 
		bb.FromDate, 
		bb.ToDate, 
		bb.ReturnedDate as ReturnedDate 
	FROM 
		BookRequests br
	JOIN 
		Books b ON br.BookId = b.BookId
	JOIN 
		Status s ON s.StatusId = br.RequestStatus
	LEFT JOIN 
		BorrowedBooks bb ON bb.BookRequestId = br.BookRequestId
	WHERE 
		br.UserId = @userId;

end
GO
/****** Object:  StoredProcedure [dbo].[spGetUserDetails]    Script Date: 22-11-2024 10:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spGetUserDetails]
@email nvarchar(100)
as begin
	select * from Users where EmailId = @email
end
GO
/****** Object:  StoredProcedure [dbo].[spRequestBook]    Script Date: 22-11-2024 10:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRequestBook]
    @userId INT,
    @bookId INT
AS
BEGIN
    -- Start a transaction to ensure data consistency
    BEGIN TRANSACTION;

    DECLARE @availableBooks INT;

    -- Get the current number of available books
    SELECT @availableBooks = AvailableBooks 
    FROM Books 
    WHERE BookId = @bookId;

    -- Check if the book is available
    IF (@availableBooks > 0)
    BEGIN
        -- Insert the book request
        INSERT INTO BookRequests (UserId, BookId, RequestedDate, RequestStatus)
        VALUES (@userId, @bookId, GETDATE(), 4);

        -- Update the available books count
        UPDATE Books
        SET AvailableBooks = AvailableBooks - 1
        WHERE BookId = @bookId;

        -- Commit the transaction
        COMMIT TRANSACTION;

        -- Return a success message
        SELECT 'Book request successful.' AS Message;
    END
    ELSE
    BEGIN
        -- Rollback the transaction if the book is unavailable
        ROLLBACK TRANSACTION;

        -- Return a message indicating the book is unavailable
        SELECT 'Your book is unavailable. Please request after some days.' AS Message;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[spRequestBookReturn]    Script Date: 22-11-2024 10:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRequestBookReturn]  
    @bookRequestId INT  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    -- Check if the book request exists and is eligible for return  
    IF EXISTS (SELECT 1 FROM BorrowedBooks WHERE BookRequestId = @bookRequestId)  
    BEGIN  
        -- Update the return status of the book request  
        UPDATE BorrowedBooks  
        SET ReturnStatus = 7 -- Assuming '7' represents the status for "Return Requested"  
        WHERE BookRequestId = @bookRequestId;  

		update BookRequests set RequestStatus = 7 where BookRequestId = @bookRequestId; 
    END  
    ELSE  
    BEGIN  
        -- If the book request ID does not exist, return an error message  
        RAISERROR('Invalid Book Request ID. The book request does not exist.', 16, 1);  
    END  
END;
GO
