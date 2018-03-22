package main

import (
	"os"
	"time"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	r.GET("/", func(c *gin.Context) {
		c.String(200, "OK")
	})

	r.GET("/now", func(c *gin.Context) {
		c.String(200, time.Now().Format(time.RFC3339))
	})

	r.GET("/ip", func(c *gin.Context) {
		c.String(200, c.ClientIP())
	})

	r.GET("/agent", func(c *gin.Context) {
		c.String(200, c.GetHeader("User-Agent"))
	})

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "I'm not big on sermons - broken bones teach better lessons",
		})
	})
	r.Run(os.Getenv("ILLAOI_PORT"))
}
