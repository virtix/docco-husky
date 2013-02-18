assert = require 'assert'


describe 'Array', ->
    describe '#indexOf()', ->
        it 'Should return -1 when item is not found in Array', ->
            assert.equal -1, [1,2,3].indexOf(0)
            assert.equal -1, [1,2,3].indexOf(-1)
        it 'Should return the index of the array where the item. This should always be greater than -1', ->
            assert.equal 0, [-1,0,1].indexOf(-1)
            assert.equal 1, [-1,0,1].indexOf(0)
            assert.equal 2, [-1,0,1].indexOf(1)

suite 'Some Test Suite', ->
    test 'Something should be equal because I say so', ->
        assert.equal 1,1
    test 'Something should be true because I want it that way', ->
        assert.ok 1==1

    suite 'Some nested test suite', ->
        test 'Something else', ->
            assert.ok true



