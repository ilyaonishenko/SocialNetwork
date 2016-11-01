package model;

/**
 * Created by wopqw on 01.11.16.
 */
public enum Role {
    ADMIN {
        @Override
        public String toString() {
            return "admin";
        }
    },
    MODERATOR {
        @Override
        public String toString() {
            return "moderator";
        }
    },
    USER {
        public String toString() {
            return "user";
        }
    };
}
