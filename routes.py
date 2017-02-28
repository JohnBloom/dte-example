from wordvice import posts

ROUTE_MAP = {
    "GET:/wordvice/posts": posts.get_posts,
    "POST:/wordvice/posts": posts.post_post,
    "GET:/wordvice/posts/{date}": posts.get_post,
}
