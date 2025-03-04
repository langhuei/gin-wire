package service

import (
    "context"
    "github.com/google/wire"
)

// ProviderSet is service providers.
var ProviderSet = wire.NewSet(NewUserService, NewJwtService, NewMediaService)

// Transaction 新增事务接口方法
type Transaction interface {
    ExecTx(context.Context, func(ctx context.Context) error) error
}
