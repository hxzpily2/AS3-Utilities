package skyboy.utils {
	/**
	 * StringBuffer by skyboy. January 29th 2012.
	 * Visit http://github.com/skyboy for documentation, updates
	 * and more free code.
	 *
	 *
	 * Copyright (c) 2010, skyboy
	 *    All rights reserved.
	 *
	 * Permission is hereby granted, free of charge, to any person
	 * obtaining a copy of this software and associated documentation
	 * files (the "Software"), to deal in the Software with
	 * restriction, with limitation the rights to use, copy, modify,
	 * merge, publish, distribute, sublicense copies of the Software,
	 * and to permit persons to whom the Software is furnished to do so,
	 * subject to the following conditions and limitations:
	 *
	 * ^ Attribution will be given to:
	 *  	skyboy, http://www.kongregate.com/accounts/skyboy;
	 *  	http://github.com/skyboy; http://skybov.deviantart.com
	 *
	 * ^ Redistributions of source code must retain the above copyright notice,
	 * this list of conditions and the following disclaimer in all copies or
	 * substantial portions of the Software.
	 *
	 * ^ Redistributions of modified source code must be marked as such, with
	 * the modifications marked and ducumented and the modifer's name clearly
	 * listed as having modified the source code.
	 *
	 * ^ Redistributions of source code may not add to, subtract from, or in
	 * any other way modify the above copyright notice, this list of conditions,
	 * or the following disclaimer for any reason.
	 *
	 * ^ Redistributions in binary form must reproduce the above copyright
	 * notice, this list of conditions and the following disclaimer in the
	 * documentation and/or other materials provided with the distribution.
	 *
	 * THE SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
	 * IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
	 * NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
	 * PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
	 * OR COPYRIGHT HOLDERS OR CONTRIBUTORS  BE LIABLE FOR ANY CLAIM, DIRECT,
	 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
	 * OR OTHER LIABILITY,(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
	 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
	 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
	 * WHETHER AN ACTION OF IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
	 * NEGLIGENCE OR OTHERWISE) ARISING FROM, OUT OF, IN CONNECTION OR
	 * IN ANY OTHER WAY OUT OF THE USE OF OR OTHER DEALINGS WITH THIS
	 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	 */
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class StringBuffer {
		protected var buffer:ByteArray = new ByteArray;
		protected var backBuffer:ByteArray = new ByteArray;
		/**
		 * @param uint: size	Initial size of the buffer in bytes.
		 * @param String: str	Initial content of the buffer.
		 */
		public function StringBuffer(size:uint = 0, str:String = null):void {
			buffer.endian = Endian.BIG_ENDIAN;
			buffer.length = size;
			if (str) buffer.writeUTFBytes(str);
		}
		//{ APPEND
		public function appendByteArray(a:ByteArray, start:uint = 0, len:uint = 0):StringBuffer {
			var end:uint = start + len;
			var e:uint = a.length;
			if (end > e) end = e;
			if (start >= end) return this;
			buffer.writeBytes(a, start, end - start);
			return this;
		}
		public function appendChar(a:int):StringBuffer {
			buffer.writeByte(a);
			return this;
		}
		public function appendChars(...a):StringBuffer {
			var buffer:ByteArray = this.buffer;
			for each(var b:* in a)
				buffer.writeByte(int(b));
			return this;
		}
		public function appendCharArray(a:Array):StringBuffer {
			var buffer:ByteArray = this.buffer;
			for each(var b:* in a)
				buffer.writeByte(int(b));
			return this;
		}
		public function appendCharVectorI(a:Vector.<int>):StringBuffer {
			var buffer:ByteArray = this.buffer;
			for each(var b:int in a)
				buffer.writeByte(b);
			return this;
		}
		public function appendCharVectorU(a:Vector.<uint>):StringBuffer {
			var buffer:ByteArray = this.buffer;
			for each(var b:uint in a)
				buffer.writeByte(b);
			return this;
		}
		public function appendInt(a:int):StringBuffer {
			buffer.writeInt(a);
			return this;
		}
		public function appendInts(...a):StringBuffer {
			var buffer:ByteArray = this.buffer;
			for each(var b:* in a)
				buffer.writeInt(int(b));
			return this;
		}
		public function appendIntArray(a:Array):StringBuffer {
			var buffer:ByteArray = this.buffer;
			for each(var b:* in a)
				buffer.writeInt(int(b));
			return this;
		}
		public function appendIntVector(a:Vector.<int>):StringBuffer {
			var buffer:ByteArray = this.buffer;
			for each(var b:int in a)
				buffer.writeInt(b);
			return this;
		}
		public function appendString(a:*):StringBuffer {
			buffer.writeUTFBytes(String(a));
			return this;
		}
		public function appendStrings(...a):StringBuffer {
			var buffer:ByteArray = this.buffer;
			for each(var b:* in a)
				buffer.writeUTFBytes(String(b));
			return this;
		}
		public function appendStringArray(a:Array):StringBuffer {
			var buffer:ByteArray = this.buffer;
			for each(var b:* in a)
				buffer.writeUTFBytes(String(b));
			return this;
		}
		public function appendStringBuffer(a:StringBuffer, start:uint = 0, len:uint = 0):StringBuffer {
			var b:ByteArray = a.buffer, e:uint = b.length;
			var end:uint = start + len;
			if (end > e) end = e;
			if (start >= end) return this;
			buffer.writeBytes(b, start, end - start);
			return this;
		}
		public function appendStringVector(a:Vector.<String>):StringBuffer {
			var buffer:ByteArray = this.buffer;
			for each(var b:String in a)
				buffer.writeUTFBytes(String(b));
			return this;
		}
		public function appendUintVector(a:Vector.<uint>):StringBuffer {
			var buffer:ByteArray = this.buffer;
			for each(var b:uint in a)
				buffer.writeInt(b);
			return this;
		}
		//} APPEND
		public function byteAt(i:uint):int {
			if (i < buffer.length) return buffer[i];
			return 0;
		}
		public function charAt(i:uint):String {
			return toString().charAt(i);
		}
		public function clear():void {
			buffer.clear();
			backBuffer.clear();
		}
		public function count(str:String):uint {
			if (!str) return 0;
			var a:ByteArray = buffer, b:ByteArray = backBuffer;
			var p:uint = a.position, e:uint = a.length, i:uint, c:uint;
			b.clear();
			b.writeUTFBytes(str);
			a.position = 0;
			while (e--) {
				if (a.readByte() == b[i]) {
					++i;
					if (i == b.length) ++c, i = 0;
				} else i = 0;
			}
			i = a.position - i;
			a.position = p;
			return c;
		}
		public function countChar(char:int):uint {
			var a:ByteArray = buffer, i:uint, e:uint = a.length, c:uint;
			while (i < e) c += uint(a[i] == char), ++i;
			return c;
		}
		public function deleteCharAt(i:uint):void {
			var a:ByteArray = buffer, l:uint = a.length - 1;
			if (int(!length) | int(i >= l)) return;
			var p:uint = a.position;
			a.position = i;
			a.writeBytes(a, i + 1, l - i);
			a.position = p - 1;
		}
		public function deleteCharsAt(i:uint, len:uint):void {
			var a:ByteArray = buffer, l:uint = a.length - len;
			if (int(!length) | int(i >= l)) return;
			var p:uint = a.position;
			a.position = i;
			a.writeBytes(a, i + len, l - i);
			a.position = p - len;
		}
		public function empty():Boolean {
			return !buffer.position;
		}
		public function getBytesAt(start:uint, end:uint, dst:ByteArray = null, dstStart:uint = 0):ByteArray {
			if (!dst) dst = new ByteArray;
			if (dstStart < dst.length) dstStart = dst.length;
			dst.writeBytes(buffer, start, end);
			return dst;
		}
		//{ INSERT
		public function insertByteArray(offset:uint, a:ByteArray, start:int = 0, end:int = 0):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendByteArray(a, start, end);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			var e:uint = a.length;
			if (end > e) end = e;
			if (start > end) return this;
			buffer.writeBytes(a, start, end);
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		public function insertChar(offset:uint, a:int):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendChar(a);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			buffer.writeByte(a);
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		public function insertChars(offset:uint, ...a):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendCharArray(a);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			for each(var b:* in a)
				buffer.writeByte(int(b));
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		public function insertCharArray(offset:uint, a:Array):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendCharArray(a);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			for each(var b:* in a)
				buffer.writeByte(int(b));
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		public function insertCharVectorI(offset:uint, a:Vector.<int>):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendCharVectorI(a);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			for each(var b:int in a)
				buffer.writeByte(b);
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		public function insertCharVectorU(offset:uint, a:Vector.<uint>):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendCharVectorU(a);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			for each(var b:uint in a)
				buffer.writeByte(b);
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		public function insertInt(offset:uint, a:int):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendInt(a);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			buffer.writeInt(a);
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		public function insertInts(offset:uint, ...a):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendIntArray(a);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			for each(var b:* in a)
				buffer.writeInt(int(b));
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		public function insertIntArray(offset:uint, a:Array):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendIntArray(a);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			for each(var b:* in a)
				buffer.writeInt(int(b));
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		public function insertIntVector(offset:uint, a:Vector.<int>):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendIntVector(a);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			for each(var b:int in a)
				buffer.writeInt(b);
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		public function insertString(offset:uint, a:*):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendString(a);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			buffer.writeUTFBytes(String(a));
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		public function insertStrings(offset:uint, ...a):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendStringArray(a);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			for each(var b:* in a)
				buffer.writeUTFBytes(String(b));
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		public function insertStringArray(offset:uint, a:Array):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendStringArray(a);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			for each(var b:* in a)
				buffer.writeUTFBytes(String(b));
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		public function insertStringBuffer(offset:uint, a:StringBuffer, start:int = 0, end:int = 0):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendStringBuffer(a, start, end);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			var b:ByteArray = a.buffer, e:uint = b.length;
			if (end > e) end = e;
			if (start > end) return this;
			buffer.writeBytes(b, start, end);
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		public function insertStringVector(offset:uint, a:Vector.<String>):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendStringVector(a);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			for each(var b:String in a)
				buffer.writeUTFBytes(String(b));
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		public function insertUintVector(offset:uint, a:Vector.<uint>):StringBuffer {
			var buffer:ByteArray = this.buffer;
			if (offset > length) {
				appendUintVector(a);
				return this;
			}
			var tem:uint = buffer.position;
			if (offset < buffer.position) buffer.position = offset;
			backBuffer.clear();
			backBuffer.writeBytes(buffer, offset, 0);
			for each(var b:uint in a)
				buffer.writeInt(b);
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			return this;
		}
		//} INSERT
		public function indexOf(str:String, start:uint = 0):Number {
			if (!str || start >= length) return -1;
			var a:ByteArray = buffer, b:ByteArray = backBuffer;
			var p:uint = a.position, e:uint = a.length, i:uint;
			b.clear();
			b.writeUTFBytes(str);
			a.position = 0;
			while (e--) {
				if (a.readByte() == b[i]) {
					++i;
					if (i == b.length) break;
				} else i = 0;
			}
			i = a.position - i;
			a.position = p;
			if (~e) return Number(i);
			return -1;
		}
		public function indexOfChar(char:int, start:uint = 0):Number {
			if (start >= length) return -1;
			var a:ByteArray = buffer;
			var p:uint = a.position, e:uint = a.length;
			a.position = 0;
			while (e--)
				if (a.readByte() == char) break;
			var i:uint = a.position - i;
			a.position = p;
			if (~e) return Number(i);
			return -1;
		}
		public function lastIndexOf(str:String, start:uint = uint.MAX_VALUE):Number {
			if (!str || start >= length) return -1;
			var a:ByteArray = buffer, b:ByteArray = backBuffer;
			var p:uint = a.position, e:uint = a.length, i:uint, l:uint;
			b.clear();
			b.writeUTFBytes(str);
			a.position = 0;
			if (start < e) e = start;
			while (e--) {
				if (a.readByte() == b[i]) {
					++i;
					if (i == b.length) l = a.position - i, i = 0;
				} else i = 0;
			}
			a.position = p;
			if (~e) return Number(l);
			return -1;
		}
		public function lastIndexOfChar(char:int, start:uint = uint.MAX_VALUE):Number {
			if (start >= length) return -1;
			var a:ByteArray = buffer, e:uint = a.length;
			if (start < e) e = start;
			while (e--)
				if (a[e] == char) return Number(e);
			return -1;
		}
		public function get length():uint {
			return buffer.length;
		}
		public function set length(l:uint):void {
			buffer.length = l;
			if (l < buffer.position) buffer.position = l;
		}
		//{ REPLACE
		public function replace(start:uint, str:String):StringBuffer {
			var i:uint = buffer.position;
			buffer.position = start;
			buffer.writeUTFBytes(String(str));
			if (buffer.position < i) buffer.position = i;
			return this;
		}
		public function replaceBytes(start:uint, end:uint, bytes:ByteArray, bytesStart:uint = 0):StringBuffer {
			var a:ByteArray = buffer, i:uint = bytesStart, e:uint = bytes.length;
			if (end > a.length) end = a.length;
			while (int(start < end) & int(i < e)) a[start++] = bytes[i++];
			return this;
		}
		public function replaceChar(char:int, replace:int):uint {
			var a:ByteArray = buffer, i:uint, e:uint = buffer.length, c:int;
			while (i < e) {
				if (a[i] == char) ++c, a[i] = replace;
				++i;
			}
			return c;
		}
		public function replaceCharVoid(char:int, replace:int):StringBuffer {
			var a:ByteArray = buffer, i:uint, e:uint = buffer.length;
			while (i < e) {
				if (a[i] == char) a[i] = replace;
				++i;
			}
			return this;
		}
		public function replaceFirstChar(char:int, replace:int):StringBuffer {
			var a:ByteArray = buffer, i:uint, e:uint = buffer.length;
			while (i < e) {
				if (a[i] == char) {
					a[i] = replace;
					return this;
				}
				++i;
			}
			return this;
		}
		public function replaceLastChar(char:int, replace:int):StringBuffer {
			var a:ByteArray = buffer, e:uint = buffer.length;
			while (e--) {
				if (a[e] == char) {
					a[e] = replace;
					return this;
				}
			}
			return this;
		}
		public function replaceNthChar(char:int, replace:int, n:uint):StringBuffer {
			var a:ByteArray = buffer, i:uint, e:uint = buffer.length, c:uint;
			while (i < e) {
				if (a[i] == char) {
					if (c++ == n) {
						a[i] = replace;
						return this;
					}
				}
				++i;
			}
			return this;
		}
		public function replaceRange(start:uint, end:uint, str:String, strStart:uint = 0):StringBuffer {
			var a:ByteArray = buffer, i:uint = strStart, e:uint = str.length;
			if (end > a.length) end = a.length;
			while (int(start < end) & int(i < e)) a[start++] = str.charCodeAt(i++);
			return this;
		}
		//} REPLACE
		/**
		 * Discards the current buffers and creates new ones.
		 * @return ByteArray:	The old ByteArray buffer.
		 */
		public function reset(newSize:uint = 0):ByteArray {
			var a:ByteArray = buffer;
			buffer = new ByteArray;
			backBuffer = new ByteArray;
			buffer.length = newSize;
			return a;
		}
		public function reverse():StringBuffer {
			var a:ByteArray = buffer, i:uint, l:uint = a.length, v:int;
			while (i < l) {
				v = a[i];
				a[i] = a[l];
				a[l] = v;
				++i, --l;
			}
			return this;
		}
		public function setByteAt(i:uint, v:int):StringBuffer {
			if (i < buffer.length) buffer[i] = v;
			return this;
		}
		public function setCharAt(i:uint, char:String):StringBuffer {
			if (!char || char.length !== 1) throw new ArgumentError("Char length must be 1.");
			if (i >= length) throw new ArgumentError("Index " + i + " outside range " + length + ".");
			backBuffer.clear();
			if (i) backBuffer.writeUTFBytes(toString(0, i - 1));
			backBuffer.writeUTFBytes(char);
			backBuffer.writeUTFBytes(toString(i + 1));
			buffer.clear();
			buffer.writeBytes(backBuffer, 0, backBuffer.length);
			backBuffer = new ByteArray;
			return this;
		}
		/**
		 * Returns the length of the string to the first null byte.
		 * If there are no null bytes, this function returns the same value the length property returns.
		 * @return uint:	The length of the string to the first null byte.
		 */
		public function size():uint {
			var a:ByteArray = buffer;
			if (!a.length) return 0;
			var p:uint = a.position, e:uint = a.length;
			a.position = 0;
			while (e && a.readByte()) --e;
			var l:uint = a.position;
			a.position = p;
			return l - 1 * int(e != 0);
		}
		public function subbuf(start:uint = 0, len:uint = uint.MAX_VALUE):StringBuffer {
			var a:StringBuffer = new StringBuffer();
			a.appendStringBuffer(this, start, len);
			return a;
		}
		public function subbuffer(start:uint,  end:uint = uint.MAX_VALUE):StringBuffer {
			var a:StringBuffer = new StringBuffer(), e:uint = length;
			if (end > e) end = e;
			a.appendStringBuffer(this, start, end - start);
			return a;
		}
		public function substr(start:uint = 0, len:uint = uint.MAX_VALUE):String {
			if (len) return toString(start, Math.min(Number(start) + Number(len), uint.MAX_VALUE));
			return '';
		}
		public function substring(start:uint,  end:uint = uint.MAX_VALUE):String {
			if (end > start) return toString(start, end);
			return '';
		}
		public function toString(start:uint = 0, end:uint = 0):String {
			var a:ByteArray = buffer, i:int = a.position;
			if (int(!end) | int(end > i)) end = i;
			if (start >= end) return '';
			a.position = start;
			var r:String = a.readUTFBytes(end - start);
			a.position = i;
			return r;
		}
		/**
		 * Trims the internal array down to the passed value if $size is > 0; otherwise trims the inernal array to the first null byte.
		 * If the string contains no null bytes and $size is 0, this method does nothing.
		 * @param  uint: $size	The length to trim the interal array to. (default: 0)
		 * @return uint:	The new length of the internal array.
		 */
		public function trimToSize($size:uint = 0):uint {
			var i:uint = $size || size();
			if (i >= buffer.length) return buffer.length;
			buffer.position = i;
			buffer.length = i;
			return i;
		}
		/**
		 * Trims the internal array down to the passed value if $size is > 0; otherwise trims the inernal array to the first null byte.
		 * If the string contains no null bytes and $size is 0, this method does nothing.
		 * @param  uint: $size	The length to trim the interal array to. (default: 0)
		 * @return StringBuffer:	A reference to this StringBuffer.
		 */
		public function trimToSizeVoid($size:uint = 0):StringBuffer {
			var i:uint = $size || size();
			if (i >= buffer.length) return this;
			buffer.position = i;
			buffer.length = i;
			return this;
		}
	}
}