typedef struct {
  CURL *handle;
  struct curl_httppost *form;
  struct curl_slist *headers;
} reference;

CURL* get_handle(SEXP ptr);
reference* get_ref(SEXP ptr);
void assert(CURLcode res);
void stop_for_status(CURL *http_handle);
SEXP slist_to_vec(struct curl_slist *slist);
struct curl_slist* vec_to_slist(SEXP vec);
struct curl_httppost* make_form(SEXP form);
void set_form(reference *ref, struct curl_httppost* newform);
void set_headers(reference *ref, struct curl_slist *newheaders);
