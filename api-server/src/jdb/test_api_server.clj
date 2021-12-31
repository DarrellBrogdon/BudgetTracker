(ns jdb.test-api-server
  (:gen-class)
  (:require
   [jdb.data :as data]
   [compojure.core :refer [defroutes GET POST context]]
   [compojure.route :as route]
   [org.httpkit.server :refer [run-server]]
   [cheshire.core :as json]))

(defonce server (atom nil))

(defn request-body->map
  [request]
  (-> request
      :body
      slurp
      (json/parse-string true)))

(defroutes app
  (context "/api/1.0" []
    (GET "/" []
      {:status 200
       :headers {"Content-Type" "application/json"}
       :body (json/generate-string (data/all-data))})
    (GET "/ledger" []
      {:status 200
       :headers {"Content-Type" "application/json"}
       :body (json/generate-string (data/read-ledger))})
    (GET "/budget" []
      {:status 200
       :headers {"Content-Type" "application/json"}
       :body (json/generate-string (data/read-budget))})
    (GET "/categories" []
      {:status 200
       :headers {"Content-Type" "application/json"}
       :body (json/generate-string (data/read-categories))})
    (GET "/expense-categories" []
      {:status 200
       :headers {"Content-Type" "application/json"}
       :body (json/generate-string (data/read-categories))})
    (POST "/ledger" request
      (let [data (request-body->map request)]
        {:status 200
         :headers {"Content-Type" "application/json"}
         :body (json/encode {:response (data/write-ledger data)})}))
    (POST "/budget" request
      (let [data (request-body->map request)]
        {:status 200
         :headers {"Content-Type" "application/json"}
         :body (json/encode {:response (data/write-budget data)})}))
    (POST "/categories" request
      (let [data (request-body->map request)]
        {:status 200
         :headers {"Content-Type" "application/json"}
         :body (json/encode {:response (data/write-categories data)})})))
  (route/resources "/")
  (route/not-found "Not Found"))

(defn start
  "Start the web server"
  []
  (if @server
    (println "Warning: Server already initialized")
    (let [port 8000]
      (println (format "Starting web server at http://localhost:%s/" port))
      (swap! server (fn [_] (run-server app {:port port}))))))

(defn stop-server
  "Stop the web server"
  []
  (when @server
    (println "Shutting down web server")
    (@server)
    (swap! server (fn [_] nil))))

#_{:clj-kondo/ignore [:clojure-lsp/unused-public-var]}
(defn restart
  "Run this on the REPL to reload log_server.clj and restart the web server"
  []
  (jdb.test-api-server/stop-server)
  (use :reload-all 'jdb.test-api-server)
  (jdb.test-api-server/start))

#_{:clj-kondo/ignore [:clojure-lsp/unused-public-var]}
(defn status
  "Get the current status of the web server"
  []
  (if @server
    (println "Web server running at http://localhost:8000/")
    (println "Web server not running!")))

(defn -main [] (start))
