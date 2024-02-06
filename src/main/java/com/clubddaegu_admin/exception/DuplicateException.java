package com.clubddaegu_admin.exception;

public class DuplicateException extends RuntimeException {

    public DuplicateException(String msg) {
        super(msg);
    }

    public DuplicateException() {
        super("Duplicated");
    }
}
