/*-- Imports --*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>

/*-- Macros --*/
#define MAX_BUFFER 100
#define err(...) fprintf(stderr, __VA_ARGS__); // Print to stderr
#define tmp_file_path "/tmp/todo-tmp"
#define SEPERATOR "::"

/*-- Helpers --*/
char *get_todo_list_path() {
    static char current_working_dir[MAX_BUFFER];
    
    strcat(current_working_dir, getenv("HOME"));
    strcat(current_working_dir, "/Documents/todo.txt");

    return current_working_dir;
}

/*-- Main Function --*/
int main(int argc, char ** argv) {


    if (argc < 2) {
        err("Nothing to do: <action> <action-args>\n");
        exit(EXIT_FAILURE);
    }

    char * todo_list_path = get_todo_list_path();

    if (!strcmp(argv[1], "list")) {
        err("\e[1mReading from:\e[0m %s\n", todo_list_path);
        
        FILE *file = fopen(todo_list_path, "r");
        if (file == NULL) {
            err("File does not exist.\n");
            exit(EXIT_FAILURE);
        }
       
        // Read & Print file till EOF
        char last_char = fgetc(file);
        while (last_char != EOF) {
            printf("%c", last_char);
            last_char = fgetc(file);
        }
        fclose(file);
    } else if (!strcmp(argv[1], "add")) {

        if (argc < 4) { err("Not Enough Arguments: add <title> <desc>\n"); exit(EXIT_FAILURE); }

        // Seed random number generator
        srand(time(0));
        
        err("\e[1mWriting to:\e[0m %s\n", todo_list_path);

        FILE *file = fopen(todo_list_path, "a+");
        
        // Check for duplicate
        while (1) {
            char buffer[MAX_BUFFER];
            if (fgets(buffer, MAX_BUFFER, file) == NULL) { break; }
            if (!strcmp(strtok(buffer, "::"), argv[2])) {
                err("Task with title: `\e[3m%s\e[0m` already exists\n", argv[2]);
                fclose(file);
                exit(EXIT_FAILURE);
            }
        }

        // Insert line
        fprintf(file, "%s%s%s%s%d\n", argv[2], SEPERATOR, argv[3], SEPERATOR, rand());
        fclose(file);

    } else if (!strcmp(argv[1], "remove")) {

        if (argc < 3) { err("Nothing to remove: <id>\n"); exit(EXIT_FAILURE); }

        FILE *in = fopen(todo_list_path, "r");
        FILE *out = fopen(tmp_file_path, "w");

        char buffer[MAX_BUFFER][MAX_BUFFER];
        int line_count = 0;
        
        while (fgets(buffer[line_count], MAX_BUFFER, in)) {
            // TODO: Make it only remove by id
            if (!strstr(buffer[line_count], argv[2])) {
                fprintf(out, "%s", buffer[line_count]);
            }
        }
        fclose(in);
        fclose(out);

        rename(tmp_file_path, todo_list_path);
    } else if (!strcmp(argv[1], "empty")) {
        fclose(fopen(todo_list_path, "w"));
        err("Emptied all tasks\n");
    }

    exit(EXIT_SUCCESS);
}

