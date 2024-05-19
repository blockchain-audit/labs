// Code generated by mockery v2.42.2. DO NOT EDIT.

package mocks

import (
	context "context"

	types "github.com/smartcontractkit/chainlink/v2/core/services/p2p/types"
	mock "github.com/stretchr/testify/mock"
)

// PeerWrapper is an autogenerated mock type for the PeerWrapper type
type PeerWrapper struct {
	mock.Mock
}

// Close provides a mock function with given fields:
func (_m *PeerWrapper) Close() error {
	ret := _m.Called()

	if len(ret) == 0 {
		panic("no return value specified for Close")
	}

	var r0 error
	if rf, ok := ret.Get(0).(func() error); ok {
		r0 = rf()
	} else {
		r0 = ret.Error(0)
	}

	return r0
}

// GetPeer provides a mock function with given fields:
func (_m *PeerWrapper) GetPeer() types.Peer {
	ret := _m.Called()

	if len(ret) == 0 {
		panic("no return value specified for GetPeer")
	}

	var r0 types.Peer
	if rf, ok := ret.Get(0).(func() types.Peer); ok {
		r0 = rf()
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).(types.Peer)
		}
	}

	return r0
}

// HealthReport provides a mock function with given fields:
func (_m *PeerWrapper) HealthReport() map[string]error {
	ret := _m.Called()

	if len(ret) == 0 {
		panic("no return value specified for HealthReport")
	}

	var r0 map[string]error
	if rf, ok := ret.Get(0).(func() map[string]error); ok {
		r0 = rf()
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).(map[string]error)
		}
	}

	return r0
}

// Name provides a mock function with given fields:
func (_m *PeerWrapper) Name() string {
	ret := _m.Called()

	if len(ret) == 0 {
		panic("no return value specified for Name")
	}

	var r0 string
	if rf, ok := ret.Get(0).(func() string); ok {
		r0 = rf()
	} else {
		r0 = ret.Get(0).(string)
	}

	return r0
}

// Ready provides a mock function with given fields:
func (_m *PeerWrapper) Ready() error {
	ret := _m.Called()

	if len(ret) == 0 {
		panic("no return value specified for Ready")
	}

	var r0 error
	if rf, ok := ret.Get(0).(func() error); ok {
		r0 = rf()
	} else {
		r0 = ret.Error(0)
	}

	return r0
}

// Start provides a mock function with given fields: _a0
func (_m *PeerWrapper) Start(_a0 context.Context) error {
	ret := _m.Called(_a0)

	if len(ret) == 0 {
		panic("no return value specified for Start")
	}

	var r0 error
	if rf, ok := ret.Get(0).(func(context.Context) error); ok {
		r0 = rf(_a0)
	} else {
		r0 = ret.Error(0)
	}

	return r0
}

// NewPeerWrapper creates a new instance of PeerWrapper. It also registers a testing interface on the mock and a cleanup function to assert the mocks expectations.
// The first argument is typically a *testing.T value.
func NewPeerWrapper(t interface {
	mock.TestingT
	Cleanup(func())
}) *PeerWrapper {
	mock := &PeerWrapper{}
	mock.Mock.Test(t)

	t.Cleanup(func() { mock.AssertExpectations(t) })

	return mock
}
