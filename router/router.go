package router

import (
    "github.com/gin-gonic/gin"
    "github.com/google/wire"
    "github.com/jassue/gin-wire/app/handler/app"
    "github.com/jassue/gin-wire/app/handler/common"
    "github.com/jassue/gin-wire/app/middleware"
    "github.com/jassue/gin-wire/config"
    "github.com/jassue/gin-wire/util/path"
    "path/filepath"
)

// ProviderSet is router providers.
var ProviderSet = wire.NewSet(NewRouter)

func NewRouter(
    conf *config.Configuration,
    jwtAuthM *middleware.JWTAuth,
    recoveryM *middleware.Recovery,
    corsM *middleware.Cors,
    limiterM *middleware.Limiter,
    authH *app.AuthHandler,
    commonH *common.UploadHandler,
    ) *gin.Engine {
    if conf.App.Env == "production" {
        gin.SetMode(gin.ReleaseMode)
    }
    router := gin.New()
    router.Use(gin.Logger(), recoveryM.Handler())

    // 跨域处理
    router.Use(corsM.Handler())

    // 限流处理
    //router.Use(limiterM.Handler())

    rootDir := path.RootPath()
    // 前端项目静态资源
    router.StaticFile("/", filepath.Join(rootDir, "static/dist/index.html"))
    router.Static("/assets", filepath.Join(rootDir, "static/dist/assets"))
    router.StaticFile("/favicon.ico", filepath.Join(rootDir, "static/dist/favicon.ico"))
    // 其他静态资源
    router.Static("/public", filepath.Join(rootDir, "static"))
    router.Static("/storage", filepath.Join(rootDir, "storage/app/public"))

    // 注册 api 分组路由
    setApiGroupRoutes(router, jwtAuthM, authH, commonH)

    return router
}
