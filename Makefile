CONF_FILE := ./srcs/docker-compose.yml
MARIA_VOLUME :=
WORDPRESS_VOLUME :=

all: up

up:
	@docker compose -f $(CONF_FILE) up -d --build

down:
	@docker compose -f $(CONF_FILE) down

re:
	@docker compose -f $(CONF_FILE) up -d --build

clean:
	@docker compose $(CONF_FILE) stop;\
	docker system prune -af

fclean: clean
	# rm -rf $(MARIA_VOLUME) $(WORDPRESS_VOLUME)

status:
	@docker compose -f $(CONF_FILE) ps

.PHONY: all up re down clean
