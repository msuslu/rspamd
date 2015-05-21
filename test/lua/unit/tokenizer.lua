context("Text tokenization test", function()
  local util = require "rspamd_util"
  local logger = require "rspamd_logger"
  test("Tokenize simple text", function()
    local cases = {
      {"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer mattis, nibh",
        {"Lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit",
        "Integer", "mattis", "nibh"
        }
      },
      {"Հետաքրքրվողների համար ոտորև ներկայացված",
        {"Հետաքրքրվողների", "համար", "ոտորև", "ներկայացված"}
      },
      {"", {}},
      {",,,,,", {}},
      {"word,,,,,word    ", {"word", "word"}},
      {"word", {"word"}},
      {",,,,word,,,", {"word"}}
    }
    
    for _,c in ipairs(cases) do
      local w = util.tokenize_text(c[1])
      if #c[2] == 0 then
        assert_equal(#w, 0, "must not have tokens " .. c[1])
      else
        assert_not_nil(w, "must tokenize " .. c[1])
        
        for i,wrd in ipairs(w) do
          assert_equal(wrd, c[2][i])
        end
      end
    end
  end)
    test("Tokenize simple text (legacy)", function()
    local cases = {
      -- First token is bad
      {"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer mattis, nibh",
        {"orem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit",
        "Integer", "mattis", "nibh"
        }
      },
      -- Unicode is broken
      --{"Հետաքրքրվողների համար ոտորև ներկայացված",
      --  {"Հետաքրքրվողների", "համար", "ոտորև", "ներկայացված"}
      --},
      {"", {}},
      {",,,,,", {}},
      {"word,,,,,word    ", {"ord", "word"}},
      {"word", {"ord"}},
      {",,,,word,,,", {"word"}}
    }
    
    for _,c in ipairs(cases) do
      local w = util.tokenize_text(c[1], {}, true)
      if #c[2] == 0 then
        assert_equal(#w, 0, "must not have tokens " .. c[1])
      else
        assert_not_nil(w, "must tokenize " .. c[1])
        
        for i,wrd in ipairs(w) do
          assert_equal(wrd, c[2][i])
        end
      end
    end
  end)
  test("Tokenize with exceptions", function()
    local cases = {
      {"word https://example.com/path word",
        {{5, 24}},
        {"word", "exception", "word"}
      },
      {"համար https://example.com/path համար",
        {{11, 24}},
        {"համար", "exception", "համար"}
      },
      {"word https://example.com/path https://example.com/path word",
        {{5, 24}, {30, 24}},
        {"word", "exception", "exception", "word"}
      },
      {"word https://example.com/path https://example.com/path",
        {{5, 24}, {30, 24}},
        {"word", "exception", "exception"}
      },
      {"https://example.com/path https://example.com/path word",
        {{0, 24}, {25, 24}},
        {"exception", "exception", "word"}
      },
      {"https://example.com/path https://example.com/path",
        {{0, 24}, {25, 24}},
        {"exception", "exception"}
      },
      {",,,,https://example.com/path https://example.com/path    ",
        {{4, 24}, {29, 24}},
        {"exception", "exception"}
      },
    }
    
    for _,c in ipairs(cases) do
      local w = util.tokenize_text(c[1], c[2])
      if #c[3] == 0 then
        assert_equal(#w, 0, "must not have tokens " .. c[1])
      else
        assert_not_nil(w, "must tokenize " .. c[1])
        
        for i,wrd in ipairs(w) do
          assert_equal(wrd, c[3][i])
        end
      end
    end
  end)
end)