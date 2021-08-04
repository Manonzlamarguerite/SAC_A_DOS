SRC_DIR := src
OBJ_DIR := obj
BIN_DIR := bin

EXE := $(BIN_DIR)/SAC_A_DOS
ALL_EXE  := $(EXE)
SRC := $(wildcard $(SRC_DIR)/*.c)
OBJ := $(SRC:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

CC := gcc
CPPFLAGS := -Iinc -MMD -MP
CFLAGS   := -Wall -pedantic -g -O2 `pkg-config --cflags MLV`
LDFLAGS  := `pkg-config --libs-only-other --libs-only-L MLV`
LDLIBS   := -lm `pkg-config --libs-only-l MLV`

.PHONY: all clean

all: $(ALL_EXE)

$(EXE): $(OBJ) | $(BIN_DIR)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BIN_DIR) $(OBJ_DIR):
	mkdir -p $@

clean:
	@$(RM) -rv $(OBJ_DIR)

clean_all:
	@$(RM) -rv $(BIN_DIR) $(OBJ_DIR)

-include $(OBJ:.o=.d)
