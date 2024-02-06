package ru.practicum.shareit.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.CONFLICT)
public class AlreadyExistEmailException extends RuntimeException {
    public AlreadyExistEmailException() {
        super("This email already exists");
    }
}